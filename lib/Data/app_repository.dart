import 'package:installed_apps/app_info.dart';

import '../Utils/result.dart';

/// La classe atratta è stata implementata come esercizio per capire cosa fare nel caso la fonte delle App, non fosse solo in locale ma anche attraverso la rete
abstract class AppRepository {
  Future<Result<void>> loadApps();
  Set<AppInfo> getAppsByName(String filter);
}
