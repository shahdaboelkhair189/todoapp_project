import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/home/task_list/task_list_item.dart';
import 'package:todoapp_project/provider/list_provider.dart';

import '../../provider/user_provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTaksFromFireStore(userProvider.currentUser!.id);
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
            listProvider.changeSelectDate(
                selectedDate, userProvider.currentUser!.id);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff8426D6),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: listProvider.tasksList.isEmpty
              ? Center(child: Text('No Tasks Added'))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: listProvider.tasksList[index],
                    );
                  },
                  itemCount: listProvider.tasksList.length,
                ),
        ),
      ],
    );
  }
}
