import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verve/models/user_model.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/services/storage_service.dart';
import 'package:verve/services/theme_service.dart';
import 'package:verve/theme/app_theme.dart';
import 'package:verve/utils/validators.dart';
import 'package:verve/widgets/app_button.dart';
import 'package:verve/widgets/app_text_field.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _ensureProfileLoaded();
  }

  Future<void> _ensureProfileLoaded() async {
    if (ref.read(currentUserProvider) == null) {
      try {
        final storage = ref.read(storageServiceProvider);
        var user = await storage.getCurrentUser();
        if (user == null) {
          final email = await storage.read(key: StorageKeys.userEmail);
          final name = await storage.read(key: StorageKeys.userName);
          final phone = await storage.read(key: StorageKeys.userPhone);
          if (email != null || name != null || phone != null) {
            user = UserModel(
              id: 'user_fallback',
              email: email ?? 'alex.carter@verve.app',
              name: name ?? 'Alex Carter',
              phoneNumber: phone ?? '+1 (555) 123-4567',
            );
          }
        }
        if (user != null && mounted) {
          ref.read(currentUserProvider.notifier).setUser(user);
        }
      } catch (_) {
        // Keep defaults
      }
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
      // Clear provider data and delete currentuser data from storage
      await ref.read(currentUserProvider.notifier).signOut();

      if (!mounted) return;
      await AppRouter.pushNamedAndRemoveUntil(
        AppRoutes.login,
        (route) => false,
      );
    } catch (error) {
      // Ensure provider data is cleared even if storage throws an error
      ref.read(currentUserProvider.notifier).clearUser();
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to sign out: $error')));
    }
  }

  void _showEditProfileSheet() {
    final currentUser = ref.read(currentUserProvider);
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(
      text: (currentUser?.name != null && currentUser!.name!.isNotEmpty)
          ? currentUser.name!
          : 'Alex Carter',
    );
    final phoneController = TextEditingController(
      text: (currentUser?.phoneNumber != null &&
              currentUser!.phoneNumber!.isNotEmpty)
          ? currentUser.phoneNumber!
          : '+1 (555) 123-4567',
    );

    bool isSaving = false;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            final isDark = Theme.of(modalContext).brightness == Brightness.dark;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(modalContext).viewInsets.bottom,
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
                            onPressed: () => Navigator.of(modalContext).pop(),
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
                        isLoading: isSaving,
                        onPressed: isSaving
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) return;

                                setModalState(() {
                                  isSaving = true;
                                });

                                try {
                                  await Future.delayed(
                                    AppTheme.buttonLoadingDuration,
                                  );

                                  final newName = nameController.text.trim();
                                  final newPhone = phoneController.text.trim();

                                  final storage =
                                      ref.read(storageServiceProvider);
                                  final user = ref.read(currentUserProvider);
                                  final updatedUser = (user != null)
                                      ? user.copyWith(
                                          name: newName,
                                          phoneNumber: newPhone,
                                        )
                                      : UserModel(
                                          id: 'user_fallback',
                                          email: 'alex.carter@verve.app',
                                          name: newName,
                                          phoneNumber: newPhone,
                                        );
                                  await storage.saveCurrentUser(updatedUser);
                                  await storage.saveUserToList(updatedUser);
                                  ref
                                      .read(currentUserProvider.notifier)
                                      .setUser(updatedUser);

                                  await storage.write(
                                    key: StorageKeys.userName,
                                    value: newName,
                                  );
                                  await storage.write(
                                    key: StorageKeys.userPhone,
                                    value: newPhone,
                                  );

                                  if (modalContext.mounted) {
                                    Navigator.of(modalContext).pop();
                                  }

                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Profile updated successfully',
                                        ),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                } finally {
                                  if (modalContext.mounted) {
                                    setModalState(() {
                                      isSaving = false;
                                    });
                                  }
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

  Widget _buildThemeToggleRow({
    required bool isDark,
    required ValueChanged<bool> onToggle,
  }) {
    return InkWell(
      onTap: () => onToggle(!isDark),
      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      child: Padding(
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
                isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
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
                    'APPEARANCE',
                    style: isDark
                        ? AppTheme.darkProfileItemLabelStyle
                        : AppTheme.profileItemLabelStyle,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    isDark ? 'Dark Mode' : 'Light Mode',
                    style: isDark
                        ? AppTheme.darkProfileItemValueStyle
                        : AppTheme.profileItemValueStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: isDark,
              onChanged: onToggle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            Theme.of(context).brightness == Brightness.dark);
    final currentUser = ref.watch(currentUserProvider);

    final String displayName;
    if (currentUser?.name != null && currentUser!.name!.trim().isNotEmpty) {
      displayName = currentUser.name!.trim();
    } else if (currentUser?.email != null && currentUser!.email.contains('@')) {
      final part = currentUser.email.split('@').first;
      displayName = part.isNotEmpty
          ? '${part[0].toUpperCase()}${part.substring(1)}'
          : 'User';
    } else {
      displayName = 'Alex Carter';
    }

    final displayEmail =
        (currentUser?.email != null && currentUser!.email.isNotEmpty)
            ? currentUser.email
            : 'alex.carter@verve.app';
    final displayPhone =
        (currentUser?.phoneNumber != null &&
            currentUser!.phoneNumber!.isNotEmpty)
            ? currentUser.phoneNumber!
            : '+1 (555) 123-4567';

    final initial =
        displayName.isNotEmpty ? displayName[0].toUpperCase() : 'A';

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
                                displayName,
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
                                value: displayName,
                                isDark: isDark,
                              ),
                              _buildDivider(isDark),
                              _buildInfoRow(
                                icon: Icons.mail_outline_rounded,
                                label: 'EMAIL ADDRESS',
                                value: displayEmail,
                                isDark: isDark,
                              ),
                              _buildDivider(isDark),
                              _buildInfoRow(
                                icon: Icons.phone_outlined,
                                label: 'PHONE NUMBER',
                                value: displayPhone,
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        // Appearance Card (Theme Toggle)
                        Container(
                          width: double.infinity,
                          decoration: isDark
                              ? AppTheme.darkProfileCardDecoration
                              : AppTheme.profileCardDecoration,
                          child: _buildThemeToggleRow(
                            isDark: isDark,
                            onToggle: (val) {
                              ref
                                  .read(themeModeProvider.notifier)
                                  .toggleTheme();
                            },
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
