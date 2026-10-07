import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/services/storage_service.dart';
import 'package:verve/theme/app_theme.dart';
import 'package:verve/utils/validators.dart';
import 'package:verve/widgets/app_button.dart';
import 'package:verve/widgets/app_text_field.dart';

/// Verve Login screen showcasing clean styling,
/// input validation, and secure authentication state.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _handleSignIn() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate authentication request
      await Future<void>.delayed(const Duration(milliseconds: 800));

      final storage = ref.read(storageServiceProvider);
      await storage.write(
        key: StorageKeys.authToken,
        value: 'verve_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      );
      await storage.write(
        key: StorageKeys.userEmail,
        value: _emailController.text.trim(),
      );

      if (!mounted) return;

      await AppRouter.pushReplacementNamed(AppRoutes.home);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to sign in: $error')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToRegister() {
    AppRouter.pushNamed(AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final titleStyle = isDark
        ? AppTheme.darkAuthTitleStyle
        : AppTheme.authTitleStyle;
    final subtitleStyle = isDark
        ? AppTheme.darkAuthSubtitleStyle
        : AppTheme.authSubtitleStyle;
    final footerPromptStyle = isDark
        ? AppTheme.darkAuthFooterPromptStyle
        : AppTheme.authFooterPromptStyle;
    final footerActionStyle = isDark
        ? AppTheme.darkAuthFooterActionStyle
        : AppTheme.authFooterActionStyle;

    return Scaffold(
      backgroundColor: isDark
          ? AppTheme.darkAuthBackgroundColor
          : AppTheme.authBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      children: [
                        const Spacer(flex: 3),

                        // Brand Logo & Header
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppTheme.authLogoRadius,
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: AppTheme.authBlurSigma,
                              sigmaY: AppTheme.authBlurSigma,
                            ),
                            child: Container(
                              width: AppTheme.authLogoCardSize,
                              height: AppTheme.authLogoCardSize,
                              decoration: isDark
                                  ? AppTheme.darkAuthLogoDecoration
                                  : AppTheme.authLogoDecoration,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/logo-app.png',
                                width: AppTheme.authLogoIconSize,
                                height: AppTheme.authLogoIconSize,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Text(
                          'Verve',
                          style: titleStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Unlock your peak productivity.',
                          style: subtitleStyle,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32.0),

                        // Frosted Glassmorphism Login Card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppTheme.authCardRadius,
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: AppTheme.authBlurSigma,
                              sigmaY: AppTheme.authBlurSigma,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(
                                AppTheme.authCardPadding,
                              ),
                              decoration: isDark
                                  ? AppTheme.darkAuthCardDecoration
                                  : AppTheme.authCardDecoration,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Email Field
                                    AppTextField(
                                      label: 'EMAIL ADDRESS',
                                      hintText: 'hello@verve.app',
                                      controller: _emailController,
                                      focusNode: _emailFocusNode,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      validator: Validators.email,
                                      onFieldSubmitted: (_) {
                                        _passwordFocusNode.requestFocus();
                                      },
                                    ),
                                    const SizedBox(
                                      height: AppTheme.authFieldSpacing,
                                    ),

                                    // Password Field
                                    AppTextField(
                                      label: 'PASSWORD',
                                      hintText: '••••••••',
                                      controller: _passwordController,
                                      focusNode: _passwordFocusNode,
                                      obscureText: _obscurePassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      validator: Validators.password,
                                      onFieldSubmitted: (_) => _handleSignIn(),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 20.0,
                                          color: AppTheme.textSecondary,
                                        ),
                                        splashRadius: 20.0,
                                        onPressed: _togglePasswordVisibility,
                                      ),
                                    ),
                                    const SizedBox(height: 24.0),

                                    // Sign In Button
                                    AppButton(
                                      text: 'Sign In',
                                      isLoading: _isLoading,
                                      onPressed: _handleSignIn,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(flex: 4),

                        // Footer / Create Account Prompt
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('New to Verve? ', style: footerPromptStyle),
                              GestureDetector(
                                onTap: _navigateToRegister,
                                child: Text(
                                  'Create an account',
                                  style: footerActionStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
