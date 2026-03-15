part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  const NotificationsState({required this.enabled});

  final bool enabled;

  factory NotificationsState.initial({required bool enabled}) {
    return NotificationsState(enabled: enabled);
  }

  @override
  List<Object> get props => [enabled];
}
