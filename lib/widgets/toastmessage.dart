import 'package:oktoast/oktoast.dart';

class ShowToastMessage {
  showMessage({required String message, int? duration}) {
    return showToast(message,
        position: ToastPosition.bottom,
        duration: Duration(seconds: duration ?? 5));
  }
}
