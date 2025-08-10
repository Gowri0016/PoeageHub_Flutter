import 'package:flutter/material.dart';
import '../configs/app_theme.dart';

class PrimaryLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  const PrimaryLoadingIndicator({super.key, this.size = 36, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color ?? kPrimarySwatch),
          strokeWidth: 3,
        ),
      ),
    );
  }
}
