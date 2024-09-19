import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/appcolors.dart';
import 'package:todoapp_project/firebase_utils.dart';

import '../../model/task.dart';
import '../../provider/list_provider.dart';
import '../../provider/user_provider.dart';

class TaskListItem extends StatelessWidget {
  Task task;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                var userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                FirebaseUtils.deleteTaskFromFireStore(
                        task, userProvider.currentUser!.id)
                    .then((value) {
                  print('task deleted successfully');
                  listProvider
                      .getAllTaksFromFireStore(userProvider.currentUser!.id);
                }).timeout(Duration(seconds: 1), onTimeout: () {
                  print('task deleted successfully');
                  listProvider
                      .getAllTaksFromFireStore(userProvider.currentUser!.id);
                });
              },
              backgroundColor: Appcolors.redColor,
              foregroundColor: Appcolors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        // The end action pane is the one at the right
        child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Appcolors.whiteColor,
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height *
                      0.1, //bya5od nfs size fe 2y mobile
                  width: 4,
                  color: Appcolors.primaryColor,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(task.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Appcolors.primaryColor)),
                    Text(task.description,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Appcolors.primaryColor),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.check,
                      size: 30,
                      color: Appcolors.whiteColor,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
