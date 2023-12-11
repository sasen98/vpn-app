import 'package:bot_toast/bot_toast.dart';

class CustomToast {
  static void showToast({required String message}) {
    BotToast.showText(text: message);
  }
}
