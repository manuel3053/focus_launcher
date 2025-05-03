import 'package:flutter/material.dart';
import 'package:focus_launcher/Utils/command.dart';

import '../../Data/app_repository.dart';
import '../../Utils/result.dart';

class AppsViewModel extends ChangeNotifier {
  final AppRepository _appRepository;
  Map<String, String> _apps = <String, String>{};
  String filter = "";

  late Command0 loadApps;
  late Command0 refresh;

  AppsViewModel({required AppRepository appRepository})
    : _appRepository = appRepository {
    loadApps = Command0(_loadApps)..execute();
    refresh = Command0(_refresh);
  }

  Map<String, String> get apps => getAppsByName(filter);

  Future<Result> _loadApps() async {
    if (_apps.isEmpty) {
      return _refresh();
    } else {
      return Result.ok(_apps);
    }
  }

  void setFilter(String s) {
    filter = s;
    notifyListeners();
  }

  Map<String, String> getAppsByName(String filter) {
    if (filter == "") {
      return _apps;
    }
    Map<String, String> filtered = <String, String>{};
    _apps.entries
        .where((app) => app.value.toLowerCase().startsWith(filter))
        .forEach((app) => filtered[app.key] = app.value);
    filter = "";
    return filtered;
  }

  Future<Result> _refresh() async {
    _apps.clear();
    notifyListeners();
    try {
      final result = await _appRepository.loadApps();
      switch (result) {
        case Ok<Map<String, String>>():
          _apps = result.value;
        case Ok<void>():
          return result;
        case Error<void>():
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
