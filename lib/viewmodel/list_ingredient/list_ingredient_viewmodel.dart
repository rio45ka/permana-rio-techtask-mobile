import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/common/view_state.dart';
import 'package:tech_task/data/remote/ingredient_model.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/page/list_recipe/list_recipe_page.dart';
import 'package:tech_task/services/ingredients_api.dart';
import 'package:tech_task/viewmodel/base_viewmodel.dart';

class ListIngredientViewModel extends BaseViewModel {
  IngredientsApi _api = locator<IngredientsApi>();
  String messageError = "";
  List<IngredientModel> listIngredient = [];
  DateTime selectedDate;
  List<String> ingredientsPick = [];

  Future<bool> getListIngredient() async {
    setState(ViewState.Busy);

    var success;
    var response;
    response = await _api.getListIngredient();

    if (response == null) {
      success = false;
      messageError = "Error";
    } else {
      success = true;
      listIngredient = response;
    }

    setState(ViewState.Idle);
    return success;
  }

  void setSelectedDate(DateTime time) {
    selectedDate = time;
    notifyListeners();
    resetPickedIngredients();
  }

  void togglePickedIngredient(IngredientModel ingredient) {
    if (ingredientExpired(ingredient.useBy)) {
      return;
    }

    bool picked;
    listIngredient.forEach((item) {
      if (item.title == ingredient.title) {
        item.hasSelected = !item.hasSelected;
        picked = item.hasSelected;
      }
    });

    switch (picked) {
      case true:
        ingredientsPick.add(ingredient.title);
        break;
      case false:
        ingredientsPick.remove(ingredient.title);
        break;
    }
    notifyListeners();
  }

  void resetPickedIngredients() {
    listIngredient.forEach((item) => item.hasSelected = false);
    ingredientsPick.clear();
    notifyListeners();
  }

  bool ingredientExpired(String date) {
    DateTime expiredIngredient = DateFormat("yyyy-MM-dd").parse(date);
    if (selectedDate.isBefore(expiredIngredient)) {
      return false;
    } else {
      return true;
    }
  }

  void actionGoRecipe(BuildContext context) {
    if (ingredientsPick.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListRecipePage(ingredients: ingredientsPick),
      ),
    );
  }
}
