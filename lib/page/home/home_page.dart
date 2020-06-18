import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tech_task/common/utils_widget.dart';
import 'package:tech_task/page/base_page.dart';
import 'package:tech_task/viewmodel/home/home_viewmodel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage<HomeViewModel>(
      builder: (context, value, child) => Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/img_supermarket.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Opacity(
              opacity: 0.70,
              child: Container(color: Colors.grey),
            ),
            _contentDatePicker(context, value)
          ],
        ),
      ),
    );
  }

  Widget _contentDatePicker(BuildContext context, HomeViewModel model) {
    final buildCalendar = () {
      return GestureDetector(
        onTap: () => DatePicker.showDatePicker(
          context,
          onConfirm: (date) => model.setSelectedDate(date),
          currentTime: model.selectedDate,
          locale: LocaleType.en,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [bgBoxShadowContainer()],
                ),
                child: Text(model.selectedDateValue),
              ),
            ),
            SizedBox(width: 10.0),
            Icon(Icons.calendar_today, size: 30.0, color: Colors.black)
          ],
        ),
      );
    };

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: [bgBoxShadowContainer()],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Please select date",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            SizedBox(height: 20.0),
            buildCalendar(),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  elevation: 5.0,
                  color: Colors.grey,
                  onPressed: () => model.actionSkipPickDate(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  elevation: 5.0,
                  color: Colors.red,
                  onPressed: () => model.actionGetDateAndMovePage(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.orange),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
