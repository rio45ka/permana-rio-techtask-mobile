import 'package:get_it/get_it.dart';
import 'package:tech_task/viewmodel/home/home_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupDi() {

  locator.registerFactory(() => HomeViewModel());
  
}