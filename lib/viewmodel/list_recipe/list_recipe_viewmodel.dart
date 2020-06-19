
import 'package:tech_task/common/view_state.dart';
import 'package:tech_task/data/local/dummy_data.dart';
import 'package:tech_task/data/remote/recipe_model.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/services/ingredients_api.dart';
import 'package:tech_task/viewmodel/base_viewmodel.dart';

class ListRecipeViewModel extends BaseViewModel {
  IngredientsApi _api = locator<IngredientsApi>();
  String messageError = "";
  List<RecipeModel> listRecipe = [];

  Future<bool> getListRecipe(List<String> ingredients) async {
    setState(ViewState.Busy);

    var success;
    var response;
    response = await _api.getListRecipe(ingredients);

    if (response == null) {
      success = false;
      listRecipe.addAll(listRecipeDummy);
      messageError = "Error";
    } else {
      success = true;
      listRecipe = response;
    }

    setState(ViewState.Idle);
    return success;
  }

}
