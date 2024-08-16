import 'package:flutter/foundation.dart';
import 'package:gsis/models/logged_in_user_model.dart';

class LoggedInUserProvider extends ChangeNotifier{
  late LoggedInUserModel user;
  addLoggedInUser(LoggedInUserModel loggedInUser){
    user=loggedInUser;
    notifyListeners();

  }
}