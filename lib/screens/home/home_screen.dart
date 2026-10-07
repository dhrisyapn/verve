import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verve/models/task_model.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/services/storage_service.dart';
import 'package:verve/theme/app_theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const List<TaskModel> _tasks = [
    TaskModel(
      id: 'task_1',
      title: 'Finalize Q3 Report',
      time: '10:00 AM',
      tag: 'WORK',
      isCompleted: false,
    ),
    TaskModel(
      id: 'task_2',
      title: 'Finalize Q3 Report',
      time: '10:00 AM',
      tag: 'WORK',
      isCompleted: false,
    ),
    TaskModel(
      id: 'task_3',
      title: 'Finalize Q3 Report',
      time: '10:00 AM',
      tag: 'WORK',
      isCompleted: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _ensureUserLoaded();
  }

  Future<void> _ensureUserLoaded() async {
    if (ref.read(currentUserProvider) == null) {
      try {
        final storage = ref.read(storageServiceProvider);
        final user = await storage.getCurrentUser();
        if (user != null && mounted) {
          ref.read(currentUserProvider.notifier).setUser(user);
        }
      } catch (_) {
        // Fallback gracefully
      }
    }
  }

  String _formatCurrentDate([DateTime? customTime]) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final now = customTime ?? DateTime.now();
    final weekday = weekdays[now.weekday - 1];
    final month = months[now.month - 1];
    return '$weekday, $month ${now.day}';
  }

  String _getGreeting([DateTime? customTime]) {
    final hour = (customTime ?? DateTime.now()).hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  void _navigateToProfile() {
    AppRouter.pushNamed(AppRoutes.profile);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
      displayName = 'Alex';
    }

    final userInitial =
        displayName.isNotEmpty ? displayName[0].toUpperCase() : 'A';

    return Scaffold(
      backgroundColor: isDark
          ? AppTheme.darkAuthBackgroundColor
          : AppTheme.authBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: AppTheme.homePadding,
        title: Image.asset(
          'assets/logo-app.png',
          width: AppTheme.homeLogoSize,
          height: AppTheme.homeLogoSize,
          fit: BoxFit.contain,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.homePadding),
            child: GestureDetector(
              onTap: _navigateToProfile,
              child: Container(
                width: AppTheme.homeAvatarSize,
                height: AppTheme.homeAvatarSize,
                decoration: isDark
                    ? AppTheme.darkHomeAvatarDecoration
                    : AppTheme.homeAvatarDecoration,
                alignment: Alignment.center,
                child: Text(userInitial, style: AppTheme.homeAvatarTextStyle),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.homePadding,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting & Date Section (Dynamic based on device time)
                Text(
                  _formatCurrentDate(),
                  style: isDark
                      ? AppTheme.darkHomeDateStyle
                      : AppTheme.homeDateStyle,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${_getGreeting()},\n$displayName!',
                  style: isDark
                      ? AppTheme.darkHomeGreetingStyle
                      : AppTheme.homeGreetingStyle,
                ),

                const SizedBox(height: 24.0),

                // Productivity Insight Card (Static)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.homePadding),
                  decoration: isDark
                      ? AppTheme.darkHomeInsightCardDecoration
                      : AppTheme.homeInsightCardDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRODUCTIVITY INSIGHT',
                        style: isDark
                            ? AppTheme.darkHomeInsightTitleStyle
                            : AppTheme.homeInsightTitleStyle,
                      ),
                      const SizedBox(height: 6.0),
                      Text.rich(
                        TextSpan(
                          text: 'Focus is up ',
                          style: isDark
                              ? AppTheme.darkHomeInsightTextStyle
                              : AppTheme.homeInsightTextStyle,
                          children: [
                            TextSpan(
                              text: '12%',
                              style: isDark
                                  ? AppTheme.darkHomeInsightHighlightStyle
                                  : AppTheme.homeInsightHighlightStyle,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "You're on a 4-day streak. Keep it up!",
                        style: isDark
                            ? AppTheme.darkHomeInsightSubtitleStyle
                            : AppTheme.homeInsightSubtitleStyle,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24.0),

                // Quick Action Cards (2x2 Grid) - Static Display
                Row(
                  children: [
                    Expanded(
                      child: _buildActionCard(
                        icon: Icons.add_rounded,
                        label: 'Add Task',
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: AppTheme.homeCardSpacing),
                    Expanded(
                      child: _buildActionCard(
                        icon: Icons.access_time_rounded,
                        label: 'Timer',
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.homeCardSpacing),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionCard(
                        icon: Icons.bar_chart_rounded,
                        label: 'Analytics',
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: AppTheme.homeCardSpacing),
                    Expanded(
                      child: _buildActionCard(
                        icon: Icons.description_outlined,
                        label: 'Notes',
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28.0),

                // Today's Tasks Section Header - Static Display
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Tasks",
                      style: isDark
                          ? AppTheme.darkHomeSectionTitleStyle
                          : AppTheme.homeSectionTitleStyle,
                    ),
                    Text(
                      'See all',
                      style: isDark
                          ? AppTheme.darkHomeSeeAllStyle
                          : AppTheme.homeSeeAllStyle,
                    ),
                  ],
                ),

                const SizedBox(height: 14.0),

                // Task List Items - Static Display
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tasks.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppTheme.homeCardSpacing),
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return _buildTaskItem(task: task, isDark: isDark);
                  },
                ),

                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.homeActionCardVerticalPadding,
        horizontal: AppTheme.homeActionCardHorizontalPadding,
      ),
      decoration: isDark
          ? AppTheme.darkHomeActionCardDecoration
          : AppTheme.homeActionCardDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppTheme.homeActionIconCircleSize,
            height: AppTheme.homeActionIconCircleSize,
            decoration: isDark
                ? AppTheme.darkHomeActionIconDecoration
                : AppTheme.homeActionIconDecoration,
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: isDark
                  ? AppTheme.darkHomeActionIconColor
                  : AppTheme.homeActionIconColor,
              size: AppTheme.homeActionIconSize,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            label,
            style: isDark
                ? AppTheme.darkHomeActionTitleStyle
                : AppTheme.homeActionTitleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem({required TaskModel task, required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.homeTaskCardPadding),
      decoration: isDark
          ? AppTheme.darkHomeTaskCardDecoration
          : AppTheme.homeTaskCardDecoration,
      child: Row(
        children: [
          // Checkbox (Static)
          Container(
            width: AppTheme.homeCheckboxSize,
            height: AppTheme.homeCheckboxSize,
            decoration: task.isCompleted
                ? (isDark
                      ? AppTheme.darkHomeCheckboxCheckedDecoration
                      : AppTheme.homeCheckboxCheckedDecoration)
                : (isDark
                      ? AppTheme.darkHomeCheckboxUncheckedDecoration
                      : AppTheme.homeCheckboxUncheckedDecoration),
            alignment: Alignment.center,
            child: task.isCompleted
                ? Icon(
                    Icons.check_rounded,
                    size: 14.0,
                    color: isDark
                        ? AppTheme.darkHomeTaskCheckedIconColor
                        : AppTheme.homeTaskCheckedIconColor,
                  )
                : null,
          ),

          const SizedBox(width: 16.0),

          // Title & Time Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: task.isCompleted
                      ? (isDark
                            ? AppTheme.darkHomeTaskTitleCompletedStyle
                            : AppTheme.homeTaskTitleCompletedStyle)
                      : (isDark
                            ? AppTheme.darkHomeTaskTitleStyle
                            : AppTheme.homeTaskTitleStyle),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 13.0,
                      color: isDark
                          ? AppTheme.darkHomeTaskTimeColor
                          : AppTheme.homeTaskTimeColor,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      task.time,
                      style: isDark
                          ? AppTheme.darkHomeTaskTimeStyle
                          : AppTheme.homeTaskTimeStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8.0),

          // Category Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.homeBadgeHorizontalPadding,
              vertical: AppTheme.homeBadgeVerticalPadding,
            ),
            decoration: isDark
                ? AppTheme.darkHomeTaskTagDecoration
                : AppTheme.homeTaskTagDecoration,
            child: Text(
              task.tag,
              style: isDark
                  ? AppTheme.darkHomeTaskTagStyle
                  : AppTheme.homeTaskTagStyle,
            ),
          ),
        ],
      ),
    );
  }
}
