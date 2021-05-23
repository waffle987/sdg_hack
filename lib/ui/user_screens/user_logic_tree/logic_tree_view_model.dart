import 'package:flutter/material.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/navigation_service.dart';

class LogicTreeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigationGoTo({@required String routeName}) {
    _navigationService.navigateReplacementTo(routeName);
  }

  void navigationPop() {
    _navigationService.pop();
  }
}
