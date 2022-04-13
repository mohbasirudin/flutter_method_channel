package com.beedev.flutter_method_channel

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { methodCall, result ->
            if (methodCall.method.equals(MESSAGE_METHOD_CHANNEL, true)) {
                val text = methodCall.argument<String>("text");

                val message = "Hello, I'm from Android Native $text"
                result.success(message)
            }
        }
    }

    companion object {
        private const val CHANNEL = "channel_native";
        private const val MESSAGE_METHOD_CHANNEL = "method_native";
    }
}
