import 'package:flutter/material.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/models/dialog_model.dart';
import 'package:sdg_hack/services/dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                request.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                ),
              ),
              content: Text(request.description),
              actions: <Widget>[
                if (isConfirmationDialog)
                  TextButton(
                    child: Text(
                      request.cancelTitle,
                      style: TextStyle(
                        color: kDarkTextColour,
                      ),
                    ),
                    onPressed: () {
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: false));
                    },
                  ),
                Material(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                  child: TextButton(
                    child: Text(
                      request.buttonTitle,
                      style: TextStyle(
                        color: kLightTextColour,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: true));
                    },
                  ),
                ),
              ],
            ));
  }
}
