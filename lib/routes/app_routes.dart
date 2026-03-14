import 'package:flutter/material.dart';
// import '../screens/home_screen.dart';
// login_screen removed
import '../screens/main_shell_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/reminder_management_screen.dart';
import '../screens/reminder_list_screen.dart';
import '../screens/reminder_list_editable_screen.dart';
import '../screens/reminder_list_delete_screen.dart';
import '../screens/member_detail_screen.dart';
import '../screens/create_reminder_screen.dart';
import '../screens/repeat_frequency_screen.dart';
import '../screens/voice_recording_screen.dart';
import '../screens/reminder_detail_screen.dart';
import '../screens/reminder_details_view_screen.dart';
import '../screens/notification_preview_screen.dart';
import '../screens/history_statistics_screen.dart';
import '../screens/activity_report_screen.dart';
import '../screens/activity_history_screen.dart';
import '../screens/safe_zone_alert_screen.dart';
// safe_zone_management_screen removed — merged into safe_zone_active_screen
import '../screens/safe_zone_select_member_screen.dart';
import '../screens/safe_zone_empty_screen.dart';
import '../screens/safe_zone_add_screen.dart';
import '../screens/safe_zone_detail_screen.dart';
import '../screens/safe_zone_time_rules_screen.dart';
import '../screens/safe_zone_edit_screen.dart';
import '../screens/safe_zone_delete_confirm_screen.dart';
import '../screens/safe_zone_alert_settings_screen.dart';
import '../screens/safe_zone_info_screen.dart';
import '../screens/safe_zone_config_screen.dart';
import '../screens/safe_zone_active_screen.dart';
import '../screens/safe_zone_edit_active_screen.dart';
import '../screens/medical_appointment_screen.dart';
import '../screens/physical_activity_screen.dart';
import '../screens/member_list_screen.dart';
import '../screens/safe_zone_screen.dart';
import '../screens/safe_zone_overview_screen.dart';

/// App Routes - Định nghĩa tất cả routes cho navigation
class AppRoutes {
  AppRoutes._();

  // Route names
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String mainShell = '/main';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String reminderManagement = '/reminder-management';
  static const String reminderList = '/reminder-list';
  static const String reminderListEditable = '/reminder-list-editable';
  static const String reminderListDelete = '/reminder-list-delete';
  static const String reminderDetail = '/reminder-detail';
  static const String reminderDetailsView = '/reminder-details-view';
  static const String notificationPreview = '/notification-preview';
  static const String memberDetail = '/member-detail';
  static const String memberList = '/member-list';
  static const String createReminder = '/create-reminder';
  static const String repeatFrequency = '/repeat-frequency';
  static const String voiceRecording = '/voice-recording';
  static const String historyStatistics = '/history-statistics';
  static const String activityReport = '/activity-report';
  static const String activityHistory = '/activity-history';
  static const String safeZoneAlert = '/safe-zone-alert';
  static const String safeZoneManagement = '/safe-zone-management';
  static const String safeZoneSelectMember = '/safe-zone-select-member';
  static const String safeZoneEmpty = '/safe-zone-empty';
  static const String safeZoneAdd = '/safe-zone-add';
  static const String safeZoneDetail = '/safe-zone-detail';
  static const String safeZoneTimeRules = '/safe-zone-time-rules';
  static const String safeZoneEdit = '/safe-zone-edit';
  static const String safeZoneDeleteConfirm = '/safe-zone-delete-confirm';
  static const String safeZoneAlertSettings = '/safe-zone-alert-settings';
  static const String safeZoneInfo = '/safe-zone-info';
  static const String safeZoneConfig = '/safe-zone-config';
  static const String safeZoneActive = '/safe-zone-active';
  static const String safeZoneEditActive = '/safe-zone-edit-active';
  static const String medicalAppointment = '/medical-appointment';
  static const String physicalActivity = '/physical-activity';

  static Map<String, WidgetBuilder> get routes => {
        // ── Root: Main shell (sau khi đăng nhập) ──────────────────────────────
        home: (context) => const MainShellScreen(),
        login: (context) => const MainShellScreen(), // login_screen removed
        mainShell: (context) => const MainShellScreen(),
        profile: (context) => const ProfileScreen(),

        // ── Reminder screens ──────────────────────────────────────────
        reminderManagement: (context) => const ReminderManagementScreen(),
        memberList: (context) => const MemberListScreen(),
        reminderList: (context) => const ReminderListScreen(),
        reminderListEditable: (context) => const ReminderListEditableScreen(),
        reminderListDelete: (context) => const ReminderListDeleteScreen(),
        reminderDetail: (context) => const ReminderDetailScreen(),
        reminderDetailsView: (context) => const ReminderDetailsViewScreen(),
        notificationPreview: (context) => const NotificationPreviewScreen(),
        memberDetail: (context) => const MemberDetailScreen(),
        createReminder: (context) => const CreateReminderScreen(),
        repeatFrequency: (context) => const RepeatFrequencyScreen(),
        voiceRecording: (context) => const VoiceRecordingScreen(),
        historyStatistics: (context) => const HistoryStatisticsScreen(),
        activityReport: (context) => const ActivityReportScreen(),
        activityHistory: (context) => const ActivityHistoryScreen(),

        // ── Safe zone screens ──────────────────────────────────────────
        safeZoneAlert: (context) => const SafeZoneAlertScreen(),
        safeZoneManagement: (context) => const SafeZoneOverviewScreen(),
        safeZoneSelectMember: (context) => const SafeZoneSelectMemberScreen(),
        safeZoneEmpty: (context) => const SafeZoneEmptyScreen(),
        safeZoneAdd: (context) => const SafeZoneAddScreen(),
        safeZoneDetail: (context) => const SafeZoneDetailScreen(),
        safeZoneTimeRules: (context) => const SafeZoneTimeRulesScreen(),
        safeZoneEdit: (context) => const SafeZoneEditScreen(),
        safeZoneDeleteConfirm: (context) => const SafeZoneDeleteConfirmScreen(),
        safeZoneAlertSettings: (context) => const SafeZoneAlertSettingsScreen(),
        safeZoneInfo: (context) => const SafeZoneInfoScreen(),
        safeZoneConfig: (context) => const SafeZoneConfigScreen(),
        safeZoneActive: (context) => const SafeZoneMemberScreen(),
        safeZoneEditActive: (context) => const SafeZoneEditActiveScreen(),
        medicalAppointment: (context) => const MedicalAppointmentScreen(),
        physicalActivity: (context) => const PhysicalActivityScreen(),
      };

  // ── Custom Page Transitions ─────────────────────────────────────────
  /// Slide từ phải sang trái (chuẩn iOS / Android Material 3)
  static Route<T> slideRoute<T>(Widget screen) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => screen,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (_, anim, secAnim, child) {
        final curved = CurvedAnimation(
          parent: anim,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }

  /// Fade transition (cho dialog-like screens)
  static Route<T> fadeRoute<T>(Widget screen) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => screen,
      transitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (_, anim, __, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeIn),
          child: child,
        );
      },
    );
  }

  /// Navigate to a named route
  static Future<T?> navigateTo<T>(BuildContext context, String routeName) {
    return Navigator.pushNamed<T>(context, routeName);
  }

  /// Navigate and replace current route
  static Future<T?> navigateReplaceTo<T>(
      BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed<T, T>(context, routeName);
  }

  /// Navigate and clear all routes
  static Future<T?> navigateClearTo<T>(
      BuildContext context, String routeName) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false,
    );
  }

  /// Go back
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
