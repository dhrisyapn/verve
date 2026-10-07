import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verve/models/user_model.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/services/storage_service.dart';
import 'package:verve/theme/app_theme.dart';
import 'package:verve/utils/validators.dart';
import 'package:verve/widgets/app_button.dart';
import 'package:verve/widgets/app_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  Future<void> _handleRegister() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(AppTheme.buttonLoadingDuration);
      if (!mounted) return;

      final email = _emailController.text.trim();
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();
      final password = _passwordController.text;

      final storage = ref.read(storageServiceProvider);

      // Check if user already exists with this email address
      final emailExists = await storage.userExistsWithEmail(email);
      if (emailExists) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An account with this email address already exists.'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      final newUser = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
        phoneNumber: phone,
        password: password,
      );

      // 1. Save user data into a userdata list in secure storage including password
      await storage.saveUserToList(newUser);

      // 2. Save user data to currentuser in secure storage
      await storage.saveCurrentUser(newUser);

      // Persist session tokens for full compatibility
      await storage.write(
        key: StorageKeys.authToken,
        value: 'verve_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      );
      await storage.write(
        key: StorageKeys.userEmail,
        value: email,
      );
      await storage.write(
        key: StorageKeys.userId,
        value: newUser.id,
      );
      if (name.isNotEmpty) {
        await storage.write(
          key: StorageKeys.userName,
          value: name,
        );
      }
      if (phone.isNotEmpty) {
        await storage.write(
          key: StorageKeys.userPhone,
          value: phone,
        );
      }

      // 3. Save user data to provider
      ref.read(currentUserProvider.notifier).setUser(newUser);

      if (!mounted) return;

      await AppRouter.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration failed: $error')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToLogin() {
    if (Navigator.of(context).canPop()) {
      AppRouter.pop();
    } else {
      AppRouter.pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final titleStyle = isDark
        ? AppTheme.darkRegisterTitleStyle
        : AppTheme.registerTitleStyle;
    final subtitleStyle = isDark
        ? AppTheme.darkRegisterSubtitleStyle
        : AppTheme.registerSubtitleStyle;
    final footerPromptStyle = isDark
        ? AppTheme.darkRegisterFooterPromptStyle
        : AppTheme.registerFooterPromptStyle;
    final footerActionStyle = isDark
        ? AppTheme.darkRegisterFooterActionStyle
        : AppTheme.registerFooterActionStyle;

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
                        const SizedBox(height: 12.0),

                        // Logo without container as explicitly instructed
                        Image.asset(
                          'assets/logo-app.png',
                          width: AppTheme.registerLogoSize,
                          height: AppTheme.registerLogoSize,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 16.0),

                        // Header Titles
                        Text(
                          'Create Account',
                          style: titleStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Join Verve and unlock your peak productivity.',
                          style: subtitleStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24.0),

                        // Frosted Glassmorphic Registration Card
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
                                AppTheme.registerCardPadding,
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
                                    // Full Name Field
                                    AppTextField(
                                      label: 'FULL NAME',
                                      hintText: 'John Doe',
                                      controller: _nameController,
                                      focusNode: _nameFocusNode,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      validator: Validators.name,
                                      onFieldSubmitted: (_) {
                                        _emailFocusNode.requestFocus();
                                      },
                                    ),
                                    const SizedBox(
                                      height: AppTheme.registerFieldSpacing,
                                    ),

                                    // Email Address Field
                                    AppTextField(
                                      label: 'EMAIL ADDRESS',
                                      hintText: 'hello@verve.app',
                                      controller: _emailController,
                                      focusNode: _emailFocusNode,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      validator: Validators.email,
                                      onFieldSubmitted: (_) {
                                        _phoneFocusNode.requestFocus();
                                      },
                                    ),
                                    const SizedBox(
                                      height: AppTheme.registerFieldSpacing,
                                    ),

                                    // Phone Number Field
                                    AppTextField(
                                      label: 'PHONE NUMBER',
                                      hintText: '+1 (555) 000-0000',
                                      controller: _phoneController,
                                      focusNode: _phoneFocusNode,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                      validator: Validators.phone,
                                      onFieldSubmitted: (_) {
                                        _passwordFocusNode.requestFocus();
                                      },
                                    ),
                                    const SizedBox(
                                      height: AppTheme.registerFieldSpacing,
                                    ),

                                    // Password Field with Validation
                                    AppTextField(
                                      label: 'PASSWORD',
                                      hintText: '••••••••',
                                      controller: _passwordController,
                                      focusNode: _passwordFocusNode,
                                      obscureText: _obscurePassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.next,
                                      validator: Validators.registerPassword,
                                      onFieldSubmitted: (_) {
                                        _confirmPasswordFocusNode
                                            .requestFocus();
                                      },
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
                                    const SizedBox(
                                      height: AppTheme.registerFieldSpacing,
                                    ),

                                    // Confirm Password Field with Validation
                                    AppTextField(
                                      label: 'CONFIRM PASSWORD',
                                      hintText: '••••••••',
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmPasswordFocusNode,
                                      obscureText: _obscureConfirmPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) =>
                                          Validators.confirmPassword(
                                            value,
                                            _passwordController.text,
                                          ),
                                      onFieldSubmitted: (_) =>
                                          _handleRegister(),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureConfirmPassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 20.0,
                                          color: AppTheme.textSecondary,
                                        ),
                                        splashRadius: 20.0,
                                        onPressed:
                                            _toggleConfirmPasswordVisibility,
                                      ),
                                    ),
                                    const SizedBox(height: 24.0),

                                    // Submit Button
                                    AppButton(
                                      text: 'Create Account',
                                      isLoading: _isLoading,
                                      onPressed: _handleRegister,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),
                        const SizedBox(height: 16.0),

                        // Footer / Log In Link
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: footerPromptStyle,
                              ),
                              GestureDetector(
                                onTap: _navigateToLogin,
                                child: Text(
                                  'Log in here',
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
