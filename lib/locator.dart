import 'package:get_it/get_it.dart';
import 'package:tech_task/services/ingredients_api.dart';
import 'package:tech_task/viewmodel/home/home_viewmodel.dart';
import 'package:tech_task/viewmodel/list_ingredient/list_ingredient_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupDi() {
  // Inject Api
  locator.registerLazySingleton(() => IngredientsApi());

  // Inject ViewModel
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => ListIngredientViewModel());
  
}