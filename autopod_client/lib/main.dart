import 'dart:async';
import 'package:flutter/material.dart';

import 'package:autopod_client/editor_page.dart';
import 'package:autopod_client/post.dart';

void main() async {
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Post>> _posts;
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () async {
      await _getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final Widget body = (_posts == null) ? Center(child: CircularProgressIndicator()) : _bodyBuilder();
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.create),
              onPressed: () => navigator.pushNamed("/editor").whenComplete(() async => await _getPosts()),
            ),
          )
        ]
      ),
      body: body,
    );
  }

  Widget _bodyBuilder() {
    return FutureBuilder(
      builder: (context, snapshot) {
        final navigator = Navigator.of(context);
        if (!snapshot.hasData || snapshot.data.length == 0) {
          return Center(child: Text('No posts. Create your first one!'),);
        }
        return ListView.builder(

          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            Post post = snapshot.data[index];
            return Card(child: ListTile(
              title: Text(post.title),
              trailing: Icon(Icons.format_align_justify),
              onTap: () {
                print('navigate to: ${post.id}');
                navigator.pushNamed("/editor", arguments: EditorParams(post.id)).whenComplete(() async => await _getPosts());
              },
            ));
          },
        );
      },
      future: _posts,
    );
  }

  Future<void> _getPosts() async {
    print('retrieving posts...');
    final postDb = await PostDb.create();
    final posts = postDb.listAll();
    setState(() {
      _posts = posts;
    });
  }
}
