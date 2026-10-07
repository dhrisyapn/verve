import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/services/storage_service.dart';
import 'package:verve/theme/app_theme.dart';
import 'package:verve/utils/validators.dart';
import 'package:verve/widgets/app_button.dart';
import 'package:verve/widgets/app_text_field.dart';

/// User profile screen presenting account details, editable user info,
/// and secure sign-out functionality.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String _name = 'Alex Carter';
  String _email = 'alex.carter@verve.app';
  String _phone = '+1 (555) 123-4567';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      final storage = ref.read(storageServiceProvider);
      final storedEmail = await storage.read(key: StorageKeys.userEmail);
      final storedName = await storage.read(key: StorageKeys.userName);
      final storedPhone = await storage.read(key: StorageKeys.userPhone);

      if (mounted) {
        setState(() {
          if (storedEmail != null && storedEmail.isNotEmpty) {
            _email = storedEmail;
          }
          if (storedName != null && storedName.isNotEmpty) {
            _name = storedName;
          } else if (storedEmail != null && storedEmail.isNotEmpty) {
            final part = storedEmail.split('@').first;
            if (part.isNotEmpty) {
              _name = '${part[0].toUpperCase()}${part.substring(1)} Carter';
            }
          }
          if (storedPhone != null && storedPhone.isNotEmpty) {
            _phone = storedPhone;
          }
        });
      }
    } catch (_) {
      // Keep defaults
    }
  }

  void _onBackTapped() {
    if (Navigator.of(context).canPop()) {
      AppRouter.pop();
    } else {
      AppRouter.pushReplacementNamed(AppRoutes.home);
    }
  }

  Future<void> _handleSignOut() async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final isDark = Theme.of(dialogContext).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark
              ? AppTheme.darkSurfaceColor
              : AppTheme.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            side: BorderSide(
              color: isDark ? AppTheme.darkBorderColor : AppTheme.borderColor,
            ),
          ),
          title: Text(
            'Sign Out',
            style: isDark
                ? AppTheme.darkHomeModalTitleStyle
                : AppTheme.homeModalTitleStyle,
          ),
          content: Text(
            'Are you sure you want to sign out of Verve?',
            style: isDark
                ? AppTheme.darkHomeInsightSubtitleStyle
                : AppTheme.homeInsightSubtitleStyle,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: isDark
                      ? AppTheme.darkProfileSignOutText
                      : AppTheme.profileSignOutText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldSignOut != true || !mounted) return;

    try {
      final storage = ref.read(storageServiceProvider);
      await storage.delete(key: StorageKeys.authToken);

      if (!mounted) return;
      await AppRouter.pushNamedAndRemoveUntil(
        AppRoutes.login,
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to sign out: $error')));
    }
  }

  void _showEditProfileSheet() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: _name);
    final phoneController = TextEditingController(text: _phone);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final isDark = Theme.of(sheetContext).brightness == Brightness.dark;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            decoration: isDark
                ? AppTheme.darkHomeModalDecoration
                : AppTheme.homeModalDecoration,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.homePadding,
              vertical: 24.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Profile',
                        style: isDark
                            ? AppTheme.darkHomeModalTitleStyle
                            : AppTheme.homeModalTitleStyle,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        color: isDark
                            ? AppTheme.darkTextSecondary
                            : AppTheme.textSecondary,
                        onPressed: () => Navigator.of(sheetContext).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  AppTextField(
                    label: 'FULL NAME',
                    hintText: 'Enter your name',
                    controller: nameController,
                    validator: (val) => Validators.name(val),
                  ),
                  const SizedBox(height: 16.0),
                  AppTextField(
                    label: 'PHONE NUMBER',
                    hintText: 'e.g. +1 (555) 123-4567',
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (val) =>
                        Validators.required(val, fieldName: 'Phone number'),
                  ),
                  const SizedBox(height: 24.0),
                  AppButton(
                    text: 'Save Changes',
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      final newName = nameController.text.trim();
                      final newPhone = phoneController.text.trim();

                      final storage = ref.read(storageServiceProvider);
                      await storage.write(
                        key: StorageKeys.userName,
                        value: newName,
                      );
                      await storage.write(
                        key: StorageKeys.userPhone,
                        value: newPhone,
                      );

                      if (mounted) {
                        setState(() {
                          _name = newName;
                          _phone = newPhone;
                        });
                      }

                      if (sheetContext.mounted) {
                        Navigator.of(sheetContext).pop();
                      }

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profile updated successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: AppTheme.profileItemIconSize,
            height: AppTheme.profileItemIconSize,
            decoration: isDark
                ? AppTheme.darkProfileItemIconDecoration
                : AppTheme.profileItemIconDecoration,
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 20.0,
              color: isDark
                  ? AppTheme.darkProfileIconColor
                  : AppTheme.profileIconColor,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: isDark
                      ? AppTheme.darkProfileItemLabelStyle
                      : AppTheme.profileItemLabelStyle,
                ),
                const SizedBox(height: 2.0),
                Text(
                  value,
                  style: isDark
                      ? AppTheme.darkProfileItemValueStyle
                      : AppTheme.profileItemValueStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 1.0,
        color: isDark
            ? AppTheme.darkProfileDividerColor
            : AppTheme.profileDividerColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final initial = _name.isNotEmpty ? _name[0].toUpperCase() : 'A';

    return Scaffold(
      backgroundColor: isDark
          ? AppTheme.darkAuthBackgroundColor
          : AppTheme.authBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 64.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Center(
            child: GestureDetector(
              onTap: _onBackTapped,
              child: Container(
                width: AppTheme.profileBackButtonSize,
                height: AppTheme.profileBackButtonSize,
                decoration: isDark
                    ? AppTheme.darkProfileBackButtonDecoration
                    : AppTheme.profileBackButtonDecoration,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 20.0,
                  color: isDark
                      ? AppTheme.darkTextPrimary
                      : AppTheme.textPrimary,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Profile',
          style: isDark
              ? AppTheme.darkProfileAppBarTitleStyle
              : AppTheme.profileAppBarTitleStyle,
        ),
        actions: const [SizedBox(width: 64.0)],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16.0),

                        // Avatar & Name Section
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: AppTheme.profileAvatarSize,
                                height: AppTheme.profileAvatarSize,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: AppTheme.profileAvatarSize,
                                      height: AppTheme.profileAvatarSize,
                                      decoration: isDark
                                          ? AppTheme.darkProfileAvatarDecoration
                                          : AppTheme.profileAvatarDecoration,
                                      alignment: Alignment.center,
                                      child: Text(
                                        initial,
                                        style: AppTheme.profileAvatarTextStyle,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: _showEditProfileSheet,
                                        child: Container(
                                          width:
                                              AppTheme.profileAvatarBadgeSize,
                                          height:
                                              AppTheme.profileAvatarBadgeSize,
                                          decoration: isDark
                                              ? AppTheme
                                                    .darkProfileAvatarBadgeDecoration
                                              : AppTheme
                                                    .profileAvatarBadgeDecoration,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.edit_outlined,
                                            size: 15.0,
                                            color: isDark
                                                ? AppTheme.darkProfileIconColor
                                                : AppTheme.profileIconColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                _name,
                                style: isDark
                                    ? AppTheme.darkProfileNameStyle
                                    : AppTheme.profileNameStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32.0),

                        // Profile Details Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: isDark
                              ? AppTheme.darkProfileCardDecoration
                              : AppTheme.profileCardDecoration,
                          child: Column(
                            children: [
                              _buildInfoRow(
                                icon: Icons.person_outline_rounded,
                                label: 'FULL NAME',
                                value: _name,
                                isDark: isDark,
                              ),
                              _buildDivider(isDark),
                              _buildInfoRow(
                                icon: Icons.mail_outline_rounded,
                                label: 'EMAIL ADDRESS',
                                value: _email,
                                isDark: isDark,
                              ),
                              _buildDivider(isDark),
                              _buildInfoRow(
                                icon: Icons.phone_outlined,
                                label: 'PHONE NUMBER',
                                value: _phone,
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),
                        const SizedBox(height: 32.0),

                        // Sign Out Button
                        GestureDetector(
                          onTap: _handleSignOut,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            decoration: isDark
                                ? AppTheme.darkProfileSignOutDecoration
                                : AppTheme.profileSignOutDecoration,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  size: 20.0,
                                  color: isDark
                                      ? AppTheme.darkProfileSignOutText
                                      : AppTheme.profileSignOutText,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  'Sign Out',
                                  style: isDark
                                      ? AppTheme.darkProfileSignOutStyle
                                      : AppTheme.profileSignOutStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
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
