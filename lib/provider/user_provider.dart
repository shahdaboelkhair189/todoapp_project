//data 7tt8yr 7t2sr 3la 2ktr mn widget
import 'package:flutter/cupertino.dart';
import 'package:todoapp_project/model/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser?
      currentUser; // 4elt 3ndy user w 7teto t7t fe current 34an y7tfz be data bta3to

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
