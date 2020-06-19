import 'package:flutter/material.dart';
import 'package:tech_task/common/utils_widget.dart';
import 'package:tech_task/common/view_state.dart';
import 'package:tech_task/data/remote/recipe_model.dart';
import 'package:tech_task/page/base_page.dart';
import 'package:tech_task/viewmodel/list_recipe/list_recipe_viewmodel.dart';

class ListRecipePage extends StatefulWidget {
  final List<String> ingredients;

  const ListRecipePage({Key key, this.ingredients}) : super(key: key);

  @override
  _ListRecipePageState createState() => _ListRecipePageState();
}

class _ListRecipePageState extends State<ListRecipePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage<ListRecipeViewModel>(
      onModelReady: (model) {
        model.getListRecipe(widget.ingredients);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("List Recipe"),
        ),
        body: Stack(
          children: <Widget>[
            _contentBody(context, model),
            model.state == ViewState.Busy ? loadingViewState() : Container()
          ],
        ),
      ),
    );
  }

  Widget _contentBody(BuildContext context, ListRecipeViewModel model) {
    final listContent = () {
      return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: model.listRecipe.length,
          itemBuilder: (BuildContext context, int index) =>
              _itemRecipe(model.listRecipe[index]));
    };
    return model.listRecipe == null ? Container() : listContent();
  }

  Widget _itemRecipe(RecipeModel model) {
    return ListTile(
      title: Text("${model.title}"),
      subtitle: Text("${model.desc}"),
      leading: Icon(
        Icons.cake,
        color: Colors.red,
        size: 60.0,
      ),
    );
  }
}
