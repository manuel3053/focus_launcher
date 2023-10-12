import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';

import 'Test/app.dart';
import 'Test/lock_screen.dart';

void main({
  bool enabled = false,
  Duration backgroundLockLatency = const Duration(seconds: 30),
}) {
  runApp(AppLock(
    builder: (arg) => MyApp(
      key: const Key('MyApp'),
      data: arg as String?,
    ),
    lockScreen: const LockScreen(
      key: Key('LockScreen'),
    ),
    enabled: enabled,
    backgroundLockLatency: backgroundLockLatency,
  ));
}