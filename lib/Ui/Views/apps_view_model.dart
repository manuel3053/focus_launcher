import 'package:flutter/material.dart';
import 'package:focus_launcher/Utils/command.dart';
import 'package:installed_apps/app_info.dart';

import '../../Data/app_repository.dart';
import '../../Utils/result.dart';

class AppsViewModel extends ChangeNotifier {
  final AppRepository _appRepository;
  String filter = "";

  late Command0 loadApps;

  AppsViewModel({required AppRepository appRepository})
    : _appRepository = appRepository {
    loadApps = Command0(_loadApps);
  }

  Set<AppInfo> get apps => _appRepository.getAppsByName(filter);

  Future<Result> _loadApps() async {
    filter = "";
    try {
      await _appRepository.loadApps();
      return Result.ok(null);
    } finally {
      notifyListeners();
    }
  }

  void setFilter(String s) {
    filter = s;
    notifyListeners();
  }
}
