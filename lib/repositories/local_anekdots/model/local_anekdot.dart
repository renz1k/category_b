import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';

class LocalAnekdot {
  const LocalAnekdot({
    required this.id,
    required this.text,
  });

  final String id;
  final String text;

  Anekdot toAnekdot() => Anekdot(
    id: id,
    anekdotText: text,
    source: 'local',
  );
}
