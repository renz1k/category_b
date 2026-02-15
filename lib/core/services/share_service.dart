import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareAnekdot(String text) async {
    await SharePlus.instance.share(
      ShareParams(text: '$text \nскопировано из приложения category b'),
    );
  }
}
