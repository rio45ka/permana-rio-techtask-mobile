import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/services/ingredients_api.dart';

List<String> params = ["Cheese", "Ketchup"];

void main() {
  setupDi();

  var api = locator<IngredientsApi>();

  group("Fetch data Recipe from API", () {
    test("Fetch data failed", () async {
      var result = await api.getListRecipe(params);
      expect(result, null);
    });
  });
}
