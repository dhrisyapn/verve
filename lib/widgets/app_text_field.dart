import 'package:flutter/material.dart';
import 'package:verve/theme/app_theme.dart';

/// Reusable application text field adhering to the Verve design tokens.
/// Supports uppercase section labels, custom hint text, secure obscure toggle,
/// validation, and dark mode adaptation.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.errorText,
    this.autovalidateMode,
    this.focusNode,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final bool enabled;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final labelStyle = isDark
        ? AppTheme.darkAuthFieldLabelStyle
        : AppTheme.authFieldLabelStyle;
    final inputStyle = isDark
        ? AppTheme.darkAuthFieldInputStyle
        : AppTheme.authFieldInputStyle;
    final hintStyle = isDark
        ? AppTheme.darkAuthFieldHintStyle
        : AppTheme.authFieldHintStyle;
    final errorStyle = isDark
        ? AppTheme.darkAuthFieldErrorStyle
        : AppTheme.authFieldErrorStyle;
    final fillColor = isDark
        ? AppTheme.darkAuthFieldFill
        : AppTheme.authFieldFill;
    final borderColor = isDark
        ? AppTheme.darkAuthFieldBorder
        : AppTheme.authFieldBorder;
    final focusedBorderColor = isDark
        ? AppTheme.darkAuthFieldBorderFocused
        : AppTheme.authFieldBorderFocused;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(label!, style: labelStyle),
          ),
          const SizedBox(height: AppTheme.authLabelSpacing),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          style: inputStyle,
          cursorColor: AppTheme.authBlue,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            hintText: hintText,
            hintStyle: hintStyle,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 15.0,
            ),
            suffixIcon: suffixIcon,
            errorText: errorText,
            errorStyle: errorStyle,
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.authFieldRadius),
              borderSide: BorderSide(color: borderColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.authFieldRadius),
              borderSide: BorderSide(color: borderColor, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.authFieldRadius),
              borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.authFieldRadius),
              borderSide: const BorderSide(
                color: AppTheme.errorColor,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.authFieldRadius),
              borderSide: const BorderSide(
                color: AppTheme.errorColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
