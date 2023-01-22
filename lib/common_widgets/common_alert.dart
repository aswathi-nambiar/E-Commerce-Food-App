import 'package:flutter/cupertino.dart';

/// Class responsible for creating Cupertino Popup
class CommonAlertDialog extends StatelessWidget {
  final Function()? onPositiveAction;
  final bool showPositiveActionButton;
  final bool showNegativeActionButton;
  final String positiveActionButtonName;
  final String negativeActionButtonName;
  final String title;
  final String content;
  const CommonAlertDialog(
      {Key? key,
      this.onPositiveAction,
      this.title = '',
      this.content = '',
      this.showNegativeActionButton = true,
      this.negativeActionButtonName = 'No',
      this.positiveActionButtonName = 'Yes',
      this.showPositiveActionButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _createDialog(
        context: context,
        onPositiveAction: onPositiveAction,
        title: title,
        content: content,
        showPositiveActionButton: showPositiveActionButton,
        showNegativeActionButton: showNegativeActionButton,
        positiveButtonName: positiveActionButtonName,
        negativeButtonName: negativeActionButtonName);
  }
}

/// Build the Cupertino Alert Dialog showing the message
Widget _createDialog(
        {required BuildContext context,
        Function()? onPositiveAction,
        required String title,
        required String content,
        required bool showPositiveActionButton,
        required bool showNegativeActionButton,
        required String positiveButtonName,
        required String negativeButtonName}) =>
    CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (showPositiveActionButton)
          _buildDialogAction(
              context: context,
              buttonName: positiveButtonName,
              performAction: onPositiveAction),
        if (showNegativeActionButton)
          _buildDialogAction(context: context, buttonName: negativeButtonName),
      ],
    );

/// Build the Action Button like Yes/No and perform corresponding action
_buildDialogAction(
    {required BuildContext context,
    required String buttonName,
    Function()? performAction}) {
  return CupertinoDialogAction(
    child: Text(buttonName),
    onPressed: () {
      if (performAction != null) {
        performAction();
      }
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
}
