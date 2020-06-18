import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/page/list_ingredient/list_ingredient_page.dart';
import 'package:tech_task/viewmodel/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  DateTime selectedDate;
  String selectedDateValue = "Pick Date";

  void setSelectedDate(DateTime time) {
    selectedDate = time;
    notifyListeners();
    setSelectedValue();
  }

  void setSelectedValue() {
    selectedDateValue = DateFormat("yyyy-MM-dd").format(selectedDate);
    notifyListeners();
  }

  void actionGetDateAndMovePage(BuildContext context) {
    if (selectedDate == null) return;
    _actionGoToListIngredient(context);
  }

  void actionSkipPickDate(BuildContext context) {
    selectedDate = DateTime.now();
    notifyListeners();
    _actionGoToListIngredient(context);
  }

  void _actionGoToListIngredient(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ListIngredientPage(selectedDate: selectedDate)),
        (route) => false);
  }
}
