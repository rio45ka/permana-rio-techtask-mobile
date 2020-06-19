import 'package:RecipeTask/data/remote/ingredient_model.dart';
import 'package:RecipeTask/data/remote/recipe_model.dart';
import 'package:dio/dio.dart';

class IngredientsApi {
  final String url = "https://a61d556b-57ca-423f-8706-2e8dec75d714.mock.pstmn.io";
  final Dio _dio = Dio();
  final int _connectTimeOut = 10000;

  Future<List<IngredientModel>> getListIngredient() async {
    var response;

    _dio.options.connectTimeout = _connectTimeOut;
    _dio.interceptors.add(LogInterceptor());

    try {
      response = await _dio.get("$url/ingredients");
    } catch (_) {
      return null;
    }

    List<IngredientModel> ingredients = [];
    response.data.forEach((item) {
      IngredientModel model = IngredientModel.fromJson(item);
      ingredients.add(model);
    });

    return ingredients;
  }

  Future<List<RecipeModel>> getListRecipe(List<String> params) async {
    var response;

    _dio.options.connectTimeout = _connectTimeOut;
    _dio.interceptors.add(LogInterceptor());

    try {
      response = await _dio.get("$url/recipe?ingredient=$params");
    } catch (_) {
      return null;
    }

    List<RecipeModel> recipes = [];
    response.data.forEach((item) {
      RecipeModel model = RecipeModel.fromJson(item);
      recipes.add(model);
    });

    return recipes;
  }


}