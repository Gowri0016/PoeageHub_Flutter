import 'package:flutter/material.dart';

// Your app's main navigation bar
class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0x11000000), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: [
          _buildBarItem(Icons.home, 'Home', 0),
          _buildBarItem(Icons.category, 'Categories', 1),
          _buildBarItem(Icons.shopping_cart_outlined, 'Cart', 2),
          _buildBarItem(Icons.favorite, 'Wishlist', 3),
          _buildBarItem(Icons.person, 'Account', 4),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
          letterSpacing: 0.1,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 11,
        ),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 0,
        selectedIconTheme: const IconThemeData(size: 22),
        unselectedIconTheme: const IconThemeData(size: 20),
        iconSize: 22,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: const Color(0xFFF2F6FF),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey[400],
          size: isSelected ? 22 : 20,
        ),
      ),
      label: label,
    );
  }
}
