import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('wifi-information');
  String _wifiInformation = 'Loading...';

  Future<void> _getWifiInformation() async {
    String wifiInformation;
    try {
      final String result = await platform.invokeMethod('wifiName');
      wifiInformation = result;
    } on PlatformException catch (e) {
      wifiInformation = "Failed to get wifi information: '${e.message}'.";
    }
    setState(() {
      _wifiInformation = wifiInformation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _getWifiInformation,
                child: const Text('Get Wifi Information'),
              ),
              Text(_wifiInformation),
            ],
          ),
        ),
      ),
    );
  }
}
