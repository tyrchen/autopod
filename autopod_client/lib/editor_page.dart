import 'dart:io';
import 'dart:convert';
import 'package:audioplayer/audioplayer.dart';

import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import './src/client.dart';

class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  /// Audio player
  AudioPlayer _player;


  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _focusNode = FocusNode();
    _loadDocument().then((document) {
      setState(() {
        _controller = ZefyrController(document);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // If _controller is null we show Material Design loader, otherwise
    // display Zefyr editor.
    final Widget body = (_controller == null)
        ? Center(child: CircularProgressIndicator())
        : ZefyrScaffold(
            child: ZefyrEditor(
              padding: EdgeInsets.all(16),
              controller: _controller,
              focusNode: _focusNode,
            ),
          );

    return Scaffold(
      appBar: AppBar(
        title: Text("Editor page"),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveDocument(context),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.music_note),
              onPressed: () => _playMp3(context),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.stop),
              onPressed: () => _stopMp3(context),
            ),
          )
        ],
      ),
      body: body,
    );
  }

  /// Loads the document to be edited in Zefyr.
  Future<NotusDocument> _loadDocument() async {
    final file = File(Directory.systemTemp.path + "/note.json");
    if (await file.exists()) {
      final contents = await file.readAsString();
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

  void _saveDocument(BuildContext context) {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly
    final contents = jsonEncode(_controller.document);
    // For this example we save our document to a temporary file.
    final file = File(Directory.systemTemp.path + "/note.json");
    // And show a snack bar on success.
    file.writeAsString(contents).then((_) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
    });
  }

  void _playMp3(BuildContext context) async {
    final client = SynthesizeClient();
    final text = _controller.document.toPlainText();
    print(text);
    final filename = await client.gen(text, Directory.systemTemp.path);
    print(filename);
    _player.play(filename, isLocal: true);
  }

  void _stopMp3(BuildContext context) {
    _player.stop();
  }
}
