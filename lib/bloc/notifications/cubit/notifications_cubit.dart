import 'package:bloc/bloc.dart';
import 'package:category_b/core/services/notifications/notification_service.dart';
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

  final NotificationService notificationService;
  final SettingsRepositoryInterface settingsRepository;

  Future<void> toggle(bool value) async {
    if (value) {
      final success = await notificationService.enableNotifications();

      if (!success) {
        await notificationService.openSystemSettings();
        return;
      }

      await settingsRepository.setNotificationsEnabled(true);
      emit(NotificationsState(enabled: true));
    } else {
      await notificationService.disableNotifications();
      await settingsRepository.setNotificationsEnabled(false);
      emit(NotificationsState(enabled: false));
    }
  }
}
