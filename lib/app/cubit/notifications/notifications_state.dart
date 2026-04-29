part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  const NotificationsState({required this.enabled});

  factory NotificationsState.initial({required bool enabled}) {
    return NotificationsState(enabled: enabled);
  }

  final bool enabled;

  @override
  List<Object> get props => [enabled];
}
