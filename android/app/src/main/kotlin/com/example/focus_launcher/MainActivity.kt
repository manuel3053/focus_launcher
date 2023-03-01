package com.example.focus_launcher

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity(){
    //private val METHOD_CHANNEL = "widgets"
    //private lateinit var channel: MethodChannel
/*
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)

        channel.setMethodCallHandler{
            call, result ->
            if(call.method=="getWidgets"){
                val intent = Intent(AppWidgetManager.ACTION_APPWIDGET_BIND).apply {
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_PROVIDER, info.componentName)
                    // This is the options bundle described in the preceding section.
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_OPTIONS, options)
                }
                startActivityForResult(intent, REQUEST_BIND_APPWIDGET)

            }
        }
    }*/

}
