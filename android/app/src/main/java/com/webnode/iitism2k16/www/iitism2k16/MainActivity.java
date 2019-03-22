package com.webnode.iitism2k16.www.iitism2k16;
import android.view.WindowManager.LayoutParams;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    getWindow().addFlags(LayoutParams.FLAG_SECURE);
  }
}
