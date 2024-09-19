import 'package:flutter/widgets.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  var selectDate = DateTime.now();

  void getAllTaksFromFireStore(String uId) async {
    var querySnapshot = await FirebaseUtils.getTasksCollection(uId).get();

    /// list<task>  => list<querydocumentSnapshot<task>>
    tasksList = querySnapshot.docs.map((doc) {
      /// bt7wl list mn no3 le list mn no3 tany
      return doc.data();
    }).toList();
    tasksList = tasksList.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month &&
          selectDate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();

    ///filter tasks =>  select date(user)
    ///

    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime newDate, String uId) {
    selectDate = newDate;
    getAllTaksFromFireStore(uId);
  }
}
