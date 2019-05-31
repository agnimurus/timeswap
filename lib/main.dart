import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'input_field.dart';

void main() {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.dev/testing/ for more info.
  enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(title: "Issue #2 Reproduction",),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InputFieldArea(
                    hint: "Username",
                    obscure: false,
                    icon: Icons.person_outline,
                  ),
                  InputFieldArea(
                    hint: "Password",
                    obscure: true,
                    icon: Icons.lock_outline,
                  ),
                ],
              ),
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
