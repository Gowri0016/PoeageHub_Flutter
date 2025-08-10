import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/auth_service.dart';
import '../../models/rating.dart';
import '../../models/rating_with_user.dart';

class RateUsScreen extends StatefulWidget {
  const RateUsScreen({super.key});

  @override
  State<RateUsScreen> createState() => _RateUsScreenState();
}

class _RateUsScreenState extends State<RateUsScreen> {
  int _rating = 0;
  final TextEditingController _controller = TextEditingController();
  bool _submitted = false;
  bool _userHasRated = false;
  bool _loginPrompted = false;
  List<RatingWithUser> _allRatings = [];
  bool _loadingRatings = true;

  @override
  void initState() {
    super.initState();
    _fetchRatings();
  }

  Future<void> _fetchRatings() async {
    setState(() => _loadingRatings = true);
    final snap = await FirebaseFirestore.instance
        .collection('ratings')
        .orderBy('createdAt', descending: true)
        .get();
    final userIds = snap.docs
        .map((d) => d['userId'] as String)
        .toSet()
        .toList();
    Map<String, String> userNames = {};
    if (userIds.isNotEmpty) {
      final usersSnap = await FirebaseFirestore.instance
          .collection('users')
          .where(
            'uid',
            whereIn: userIds.length > 10 ? userIds.sublist(0, 10) : userIds,
          )
          .get();
      for (var doc in usersSnap.docs) {
        userNames[doc['uid']] = doc['name'] ?? '';
      }
      // If more than 10 users, fetch the rest in batches (Firestore limitation)
      for (int i = 10; i < userIds.length; i += 10) {
        final batch = userIds.sublist(i, (i + 10).clamp(0, userIds.length));
        final usersSnapBatch = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: batch)
            .get();
        for (var doc in usersSnapBatch.docs) {
          userNames[doc['uid']] = doc['name'] ?? '';
        }
      }
    }
    final auth = Provider.of<AuthService>(context, listen: false);
    final user = auth.currentUser;
    bool userRated = false;
    final ratingsList = snap.docs.map((d) {
      final rating = Rating.fromMap(d.data());
      if (user != null && rating.userId == user.uid) userRated = true;
      final name = userNames[rating.userId] ?? 'User';
      return RatingWithUser(rating: rating, userName: name);
    }).toList();
    setState(() {
      _allRatings = ratingsList;
      _userHasRated = userRated;
      _submitted = userRated;
      _loadingRatings = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final user = auth.currentUser;
    if (user == null && !_loginPrompted) {
      Future.microtask(() async {
        setState(() => _loginPrompted = true);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Login Required'),
            content: const Text('Please log in to rate us.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      });
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Us')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _loadingRatings
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'All User Ratings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_allRatings.isEmpty) const Text('No ratings yet.'),
                    ..._allRatings.map(
                      (r) => ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < r.rating.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 22,
                            ),
                          ),
                        ),
                        title: r.rating.feedback.isNotEmpty
                            ? Text(r.rating.feedback)
                            : const Text('No feedback'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r.userName),
                            Text(
                              _formatDate(r.rating.createdAt),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 32),
                    if (!_submitted && user != null && !_userHasRated)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'How would you rate your experience?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              5,
                              (i) => IconButton(
                                icon: Icon(
                                  _rating > i ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 36,
                                ),
                                onPressed: () =>
                                    setState(() => _rating = i + 1),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextField(
                            controller: _controller,
                            minLines: 2,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Share your feedback',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.feedback_outlined),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _rating == 0
                                  ? null
                                  : () async {
                                      final rating = Rating(
                                        userId: user.uid,
                                        rating: _rating,
                                        feedback: _controller.text.trim(),
                                        createdAt: DateTime.now(),
                                      );
                                      await FirebaseFirestore.instance
                                          .collection('ratings')
                                          .doc(user.uid)
                                          .set(rating.toMap());
                                      setState(() {
                                        _submitted = true;
                                      });
                                      await _fetchRatings();
                                    },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(48),
                              ),
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    if (_submitted)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.celebration,
                            color: Colors.amber,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Thank you for your feedback!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  }
}
