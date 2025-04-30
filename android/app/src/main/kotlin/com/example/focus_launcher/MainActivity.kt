package com.example.focus_launcher

import android.content.Intent
import android.provider.Settings
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull

class MainActivity : FlutterActivity() {
  private val CHANNEL = "com.example.focus_launcher/apps";

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    MethodChannel(flutterEngine.getDartExecutor(), CHANNEL).setMethodCallHandler {
      call, result ->
        when(call.method) {
          "getInstalledApps" -> Thread { result.success(getInstalledApps()) }.start();
          "openInSettings" -> { 
            val packageName = call.argument<String>("packageName");
            if (packageName != null) {
                openInSettings(packageName)
                result.success(null)
            } else {
                result.error("INVALID_ARGUMENT", "Package name is null", null)
            }
          }
          "openApp" -> { 
            val packageName = call.argument<String>("packageName");
            if (packageName != null) {
                openApp(packageName)
                result.success(null)
            } else {
                result.error("INVALID_ARGUMENT", "Package name is null", null)
            }
          }
          else -> result.notImplemented()
        }
    }
  }

  private fun getInstalledApps(): Map<String, String> {
    return packageManager.getInstalledApplications(0)
    .filter { app -> !isSystemApp(app.packageName) }
    .associate { app -> app.packageName to packageManager.getApplicationLabel(app).toString() };
  }

  private fun openInSettings(packageName: String) {
    startActivity(Intent().apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
            action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
            data = Uri.fromParts("package", packageName, null)
        })
  }

  private fun openApp(packageName: String) {
    startActivity(packageManager.getLaunchIntentForPackage(packageName))
  }

  private fun isSystemApp(packageName: String): Boolean {
    return packageManager.getLaunchIntentForPackage(packageName) == null;
  }

}

