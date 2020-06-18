import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/viewmodel/home/home_viewmodel.dart';

DateTime dateTimeDummy = DateTime(2020, 11, 5);
DateTime now = DateTime.now();

void main() {
  setupDi();

  var viewModel = locator<HomeViewModel>();

  group("User Give the date", () {
    test("set date from date picker", () {
      viewModel.setSelectedDate(dateTimeDummy);
      expect(viewModel.selectedDate, dateTimeDummy);
    });

    test("set date to dateTime now if user click skip button", () {
      viewModel.setSelectedDate(now);
      expect(viewModel.selectedDate, now);
    });
  });
}
