import 'package:flutter/material.dart';

import 'package:autopod_client/editor_page.dart';

void main() {
  runApp(AutopodApp());
}

class AutopodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Text',
      home: HomePage(),
      routes: {
        "/editor": (context) => EditorPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Quick Start")),
      body: Center(
        child: FlatButton(
          child: Text("Open editor"),
          onPressed: () => navigator.pushNamed("/editor"),
        ),
      ),
    );
  }
}
