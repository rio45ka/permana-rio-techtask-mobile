import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tech_task/common/utils_widget.dart';
import 'package:tech_task/common/view_state.dart';
import 'package:tech_task/data/remote/ingredient_model.dart';
import 'package:tech_task/page/base_page.dart';
import 'package:tech_task/viewmodel/list_ingredient/list_ingredient_viewmodel.dart';

class ListIngredientPage extends StatefulWidget {
  final DateTime selectedDate;

  const ListIngredientPage({Key key, this.selectedDate}) : super(key: key);

  @override
  _ListIngredientPageState createState() => _ListIngredientPageState();
}

class _ListIngredientPageState extends State<ListIngredientPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage<ListIngredientViewModel>(
      onModelReady: (model) {
        model.setSelectedDate(widget.selectedDate);
        model.getListIngredient();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("List Ingredient"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              onPressed: () => _showAlertChangeDate(model),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            _contentBody(context, model),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buttonAction(model),
            ),
            model.state == ViewState.Busy ? loadingViewState() : Container()
          ],
        ),
      ),
    );
  }

  Widget _contentBody(BuildContext context, ListIngredientViewModel model) {
    final listContent = () {
      return GridView.count(
        primary: true,
        crossAxisCount: 2,
        childAspectRatio: 1.50,
        padding: const EdgeInsets.all(20),
        children: List.generate(
          model.listIngredient.length,
          (index) => GestureDetector(
              onTap: () =>
                  model.togglePickedIngredient(model.listIngredient[index]),
              child: _itemIngredient(model.listIngredient[index])),
        ),
      );
    };
    return model.listIngredient == null ? Container() : listContent();
  }

  Widget _buttonAction(ListIngredientViewModel model) {
    final buildCountIngredientPicked = () {
      return GestureDetector(
        onTap: () => _showListIngredientSelected(model),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.shopping_basket,
              color: Colors.white,
              size: 25.0,
            ),
            SizedBox(width: 5.0),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Text(
                "${model.ingredientsPick.length}",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    };

    final buildBtnConfirmIngredient = () {
      return GestureDetector(
        onTap: () => model.actionGoRecipe(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Find Recipe",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 5.0),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 25.0,
            ),
          ],
        ),
      );
    };

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        boxShadow: [bgBoxShadowContainer()],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(child: buildCountIngredientPicked()),
          Container(
            width: 1.0,
            height: 30.0,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
          ),
          Expanded(child: buildBtnConfirmIngredient()),
        ],
      ),
    );
  }

  Widget _itemIngredient(IngredientModel model) {
    final buildItemSelection = () {
      return Card(
        color: Colors.green,
        elevation: 1.5,
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    model.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Expired: ${model.useBy}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.topRight,
                child:
                    Icon(Icons.check_circle, size: 18.0, color: Colors.white),
              ),
            )
          ],
        ),
      );
    };

    final buildItemDefault = () {
      return Card(
        elevation: 1.5,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                "Expired: ${model.useBy}",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      );
    };

    return model.hasSelected == true
        ? buildItemSelection()
        : buildItemDefault();
  }

  void _showAlertChangeDate(ListIngredientViewModel model) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Warning!!"),
          content: const Text(
              "if you change the date, you will lose the item you selected, are you sure you will continue to change the date?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                DatePicker.showDatePicker(
                  context,
                  onConfirm: (date) => model.setSelectedDate(date),
                  currentTime: model.selectedDate,
                  locale: LocaleType.en,
                );
              },
              child: Text("Ok"),
            )
          ],
        );
      },
    );
  }

  void _showListIngredientSelected(ListIngredientViewModel model) {
    final buildItem = (String item) {
      return ListTile(
        title: Text(item),
      );
    };

    final buildList = () {
      return ListView.separated(
        itemBuilder: (context, index) =>
            buildItem(model.ingredientsPick[index]),
        itemCount: model.ingredientsPick.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.grey),
      );
    };

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: 350,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Ingredient Selected",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context))
                    ],
                  ),
                ),
                Expanded(
                  child: model.ingredientsPick.isNotEmpty
                      ? buildList()
                      : Center(
                          child: Text(
                            "Ingredients Empty",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
