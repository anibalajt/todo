import 'package:get_it/get_it.dart';

import 'services/Todos.service.dart';
import 'package:todo/services/Api.service.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => TodosService());
}
