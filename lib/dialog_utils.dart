import 'dart:js';

import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context,
      required String loadingLabel,
      bool barrierDismissible = true}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  loadingLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String content,
    String title = 'Title',
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName)));
    }
    if (negAction != null) {
      actions.add(ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          // if (negAction!=null){
          negAction?.call();
        }, //or
        child: Text(
          negActionName!,
        ),
      ));
    }

    showDialog(
        context: context,
        builder: // byrsmly 4kl ely 7yt3rd gowa dialogue
            (context) {
          return AlertDialog(
            content: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            title: Text(title),
            actions: actions,
          );
        });
  }
}
