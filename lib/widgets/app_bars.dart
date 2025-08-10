import 'package:flutter/material.dart';
import '../configs/app_theme.dart';

/// Global Promo Bar (dismissible)
class GlobalPromoBar extends StatefulWidget {
  final String message;
  const GlobalPromoBar({super.key, required this.message});

  @override
  State<GlobalPromoBar> createState() => _GlobalPromoBarState();
}

class _GlobalPromoBarState extends State<GlobalPromoBar> {
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    if (!_visible) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                widget.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 18),
            onPressed: () => setState(() => _visible = false),
            tooltip: 'Dismiss',
          ),
        ],
      ),
    );
  }
}

/// Main App Bar
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack;
  final VoidCallback? onBack;
  final String? title;
  final bool showSearch;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onCart;
  const MainAppBar({
    super.key,
    this.showBack = false,
    this.onBack,
    this.title,
    this.showSearch = false, // Default to false
    this.onSearch,
    this.onCart,
    required List<IconButton> actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (showBack)
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: kPrimarySwatch,
                  size: 20,
                ),
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                splashRadius: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            else
              Row(
                children: [
                  Image.asset(
                    'assets/brand/banner.png',
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            if (title != null)
              Expanded(
                child: Center(
                  child: Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
