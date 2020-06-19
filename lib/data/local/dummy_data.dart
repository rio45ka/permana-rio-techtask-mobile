
import 'package:tech_task/data/remote/ingredient_model.dart';
import 'package:tech_task/data/remote/recipe_model.dart';

List<RecipeModel> listRecipeDummy = [
  RecipeModel(
    title: "Pizza",
    desc: "Delicous Pizza",
    ingredients: ["Cheese", "Butter", "Eggs"],
  ),
  RecipeModel(
    title: "Donut",
    desc: "Delicous Donut",
    ingredients: ["Butter", "Eggs"],
  ),
  RecipeModel(
    title: "Spagheti",
    desc: "Spagheti hand made, delicious",
    ingredients: ["Tomato", "Ketchup", "Cheese"],
  )
];

List<IngredientModel> listIngredientDummy = [
  IngredientModel(
    title: "Ham",
    useBy: "2019-11-25",
    hasSelected: false,
  ),
  IngredientModel(
    title: "Cheese",
    useBy: "2019-11-05",
    hasSelected: false,
  ),
  IngredientModel(
    title: "Butter",
    useBy: "2019-11-01",
    hasSelected: false,
  )
];
