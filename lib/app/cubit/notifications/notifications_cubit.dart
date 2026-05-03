import 'package:bloc/bloc.dart';
import 'package:category_b/core/services/notifications/notification_service_interface.dart';
import 'package:category_b/repositories/settings/settings_repository_interface.dart';
import 'package:equatable/equatable.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({
    required this.notificationService,
    required this.settingsRepository,
  }) : super(
         NotificationsState.initial(
           enabled: settingsRepository.areNotificationsEnabled(),
         ),
       );

  final NotificationServiceInterface notificationService;
  final SettingsRepositoryInterface settingsRepository;

  Future<bool> toggle({required bool value}) async {
    if (value) {
      final success = await notificationService.enableNotifications();

      if (!success) {
        return false;
      }

      await settingsRepository.setNotificationsEnabled(enabled: true);
      emit(const NotificationsState(enabled: true));
      return true;
    } else {
      await notificationService.disableNotifications();
      await settingsRepository.setNotificationsEnabled(enabled: false);
      emit(const NotificationsState(enabled: false));
      return true;
    }
  }

  Future<void> openSystemSettings() async {
    await notificationService.openSystemSettings();
  }
}
