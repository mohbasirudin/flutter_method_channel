import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Method Channel',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String message = "-";
  static const platform = MethodChannel("channel_native");

  void _getNativeMessage() async {
    String result = "";
    try {
      result = await platform.invokeMethod("method_native", {
        "text": DateTime.now().toString(),
      });
    } on PlatformException catch (e) {
      result = "Failed to Invoke: ${e.message}";
    }

    setState(() {
      message = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Message from native:",
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getNativeMessage,
        child: const Icon(
          Icons.sync,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
