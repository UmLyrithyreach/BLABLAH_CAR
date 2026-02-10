import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ui/screens/ride_pref/ride_prefs_screen.dart';
import 'ui/theme/theme.dart';

// void main() {
//    runApp(const BlaBlaApp());
// }

void main() => runApp(
  DevicePreview(builder: (context) => BlaBlaApp(), enabled: !kReleaseMode),
);

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(body: RidePrefsScreen()),
    );
  }
}
