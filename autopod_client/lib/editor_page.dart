import 'dart:io';
import 'dart:convert';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:zefyr/zefyr.dart';

import './post.dart';

class EditorParams {
  final int id;
  EditorParams(this.id);
}

class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;
  Post _post;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  /// Audio player
  AudioPlayer _player;


  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _focusNode = FocusNode();
    new Future.delayed(Duration.zero, () {
      _loadDocument(context).then((map) {
        print(map);
        setState(() {
          _controller = ZefyrController(map['doc']);
          _post = map['post'];
        });
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
  Future<Map<String, dynamic>> _loadDocument(BuildContext context) async {
    final post = await _loadPost(context);
    return {
      'doc': NotusDocument.fromJson(jsonDecode(post.content)),
      'post': post,
    };
  }

  void _saveDocument(BuildContext context) async {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly
    final contents = jsonEncode(_controller.document);

    int id = _post.id;
    _post = await Post.fromText(contents);
    _post.id = id;
    print('post to save: ${_post.id}');
    final db = await PostDb.create();
    await db.update(_post);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));

  }

  void _playMp3(BuildContext context) async {
    // temporarily store it as a file
    final filename = p.join(Directory.systemTemp.path, '${_post.hash}.mp3');
    final file = File(filename);
    if (!await file.exists()) await file.writeAsBytes(_post.mp3);

    print('play mp3: $filename');
    _player.play(filename, isLocal: true);

  }

  void _stopMp3(BuildContext context) {
    _player.stop();
  }

  int _getId(BuildContext context) {
    final args = (ModalRoute.of(context).settings.arguments as EditorParams);

    if (args == null) return null;
    print('args: $args, id: ${args.id}');
    return args.id;
  }

  Future<Post> _loadPost(BuildContext context) async {
    final id = _getId(context);
    final db = await PostDb.create();
    final post = await db.getOrCreateById(id);
    return post;
  }
}
