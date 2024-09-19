import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/firebase_utils.dart';
import 'package:todoapp_project/model/task.dart';
import 'package:todoapp_project/provider/user_provider.dart';

import '../../provider/list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String title = '';
  String description = '';
  var selectDate = DateTime.now();
  final formKey = GlobalKey<FormState>();

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context).textTheme.bodyMedium),
            Form(
              key: formKey, //refrence 3la 2y 7aga gowa form

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 34an 2st5dm text form field lazm 27oto gowa form
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter task title'; //invalid
                        }
                        return null; //valid
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter task title'),
                    ),
                  ), //7aga 7yd5lha user

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        // save le text el user
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter task description'; //invalid
                        }
                        return null; //valid
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter task description'),
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.select_date,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      //34an calendar
                      onTap: () {
                        showCalendar();
                      },
                      child: Text(
                          '${selectDate.day}/${selectDate.month}/${selectDate.year}/',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    child: Text(AppLocalizations.of(context)!.add,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    /// method 7t3dyy 3la validtor for loop
    if (formKey.currentState?.validate() == true) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      Task task =
          Task(title: title, dateTime: selectDate, description: description);

      FirebaseUtils.addTaskToFireStore(task, userProvider.currentUser!.id)
          .then((value) {
        print('task added successfully');
        listProvider.getAllTaksFromFireStore(userProvider.currentUser!.id);
        Navigator.pop(context);
      }).timeout(Duration(seconds: 1), onTimeout: () {
        print('task added successfully');
        listProvider.getAllTaksFromFireStore(userProvider.currentUser!.id);
        Navigator.pop(context);
      });
    }
  }

  void showCalendar() async {
    // 34an 2zhr calendar, fe code 7ytnfz fe nfs el w2t m3 code tany
    var chosenDate = await showDatePicker(
        context: context,
        // 7gbro yfdl wa2f hena 2bl ma yroo7 satr ely b3do ,ya3ny 7y3rdly UI w fe nfs el w2t 7ya5od w2to l7d ma ynfz function m4 7y3tl el UI 34an hwa by7ml
        initialDate: DateTime.now(),
        // sa3a sanya date w d2e2a
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectDate = chosenDate;
      setState(() {});
    }
//selectDate=chosenDate ??selectDate; another way
  }
}
