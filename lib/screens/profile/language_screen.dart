import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'Hindi'},
    {'code': 'ta', 'name': 'Tamil'},
    {'code': 'te', 'name': 'Telugu'},
    {'code': 'kn', 'name': 'Kannada'},
    {'code': 'ml', 'name': 'Malayalam'},
    {'code': 'mr', 'name': 'Marathi'},
    {'code': 'gu', 'name': 'Gujarati'},
    {'code': 'pa', 'name': 'Punjabi'},
    {'code': 'bn', 'name': 'Bengali'},
    {'code': 'or', 'name': 'Odia'},
    {'code': 'as', 'name': 'Assamese'},
    {'code': 'ur', 'name': 'Urdu'},
    {'code': 'sd', 'name': 'Sindhi'},
    {'code': 'ks', 'name': 'Kashmiri'},
    {'code': 'sa', 'name': 'Sanskrit'},
    {'code': 'ne', 'name': 'Nepali'},
    {'code': 'ma', 'name': 'Manipuri'},
    {'code': 'kok', 'name': 'Konkani'},
    {'code': 'doi', 'name': 'Dogri'},
    {'code': 'bho', 'name': 'Bhojpuri'},
    {'code': 'san', 'name': 'Santhali'},
    {'code': 'mni', 'name': 'Meitei'},
  ];

  String selectedCode = 'en';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        backgroundColor: theme.colorScheme.primary,
        elevation: 2,
      ),
      body: Container(
        color: theme.colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: languages.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final lang = languages[index];
              return RadioListTile<String>(
                value: lang['code']!,
                groupValue: selectedCode,
                onChanged: (value) {
                  setState(() {
                    selectedCode = value!;
                  });
                },
                title: Text(
                  lang['name']!,
                  style: theme.textTheme.bodyLarge,
                ),
                activeColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Language set to: ' +
                      languages
                          .firstWhere((l) => l['code'] == selectedCode)['name']!)),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Save', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
