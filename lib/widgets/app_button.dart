import 'package:flutter/material.dart';
import 'package:verve/theme/app_theme.dart';

/// Reusable primary action button with loading state support and Verve styling.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 52.0,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: AppTheme.authPrimaryButtonStyle,
        child: isLoading
            ? const SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.authButtonTextColor,
                  ),
                ),
              )
            : Text(
                text,
                style: AppTheme.authButtonStyle,
              ),
      ),
    );
  }
}
