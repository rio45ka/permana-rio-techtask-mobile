import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/data/local/dummy_data.dart';
import 'package:tech_task/data/remote/ingredient_model.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/services/ingredients_api.dart';
import 'package:tech_task/viewmodel/list_ingredient/list_ingredient_viewmodel.dart';

List<IngredientModel> listIngredient = listIngredientDummy;
DateTime now = DateTime.now();
DateTime dateTimeDummy = DateTime(2019, 05, 5);

void main() {
  setupDi();

  var viewModel = locator<ListIngredientViewModel>();
  var api = locator<IngredientsApi>();

  viewModel.listIngredient.addAll(listIngredient);

  group("Fetch data from API", () {
    test("Fetch data", () async {
      var result = await api.getListIngredient();
      expect(result.length, 16);
    });
  });

  group("Picked Ingredient", () {
    test("Ingredient has Expired", () {
      bool expired;
      viewModel.setSelectedDate(now);
      expired = viewModel.ingredientExpired(listIngredient[0].useBy);
      expect(expired, true);
    });

    test("If ingredient expired, list ingredient pick not success", () {
      viewModel.setSelectedDate(now);
      viewModel.togglePickedIngredient(viewModel.listIngredient[0]);
      expect(viewModel.ingredientsPick.length, 0);
    });

    test("Successfully pick ingredient, list in ingredientPick has update", () {
      viewModel.setSelectedDate(dateTimeDummy);
      viewModel.togglePickedIngredient(viewModel.listIngredient[0]);
      expect(viewModel.ingredientsPick.length, 1);
      expect(viewModel.ingredientsPick[0], viewModel.listIngredient[0].title);
    });

    test(
        "Successfully remove ingredient from list picked, list in ingredientPick has update",
        () {
      viewModel.setSelectedDate(dateTimeDummy);
      viewModel.togglePickedIngredient(viewModel.listIngredient[0]);
      expect(viewModel.ingredientsPick.length, 1);
      expect(viewModel.ingredientsPick[0], viewModel.listIngredient[0].title);
      viewModel.togglePickedIngredient(viewModel.listIngredient[0]);
      expect(viewModel.ingredientsPick.length, 0);
    });

    test("Clear list picked ingredients, after change date", () {
      viewModel.setSelectedDate(dateTimeDummy);
      viewModel.setSelectedDate(now);
      viewModel.resetPickedIngredients();
      expect(viewModel.ingredientsPick.length, 0);
    });
  });
}
