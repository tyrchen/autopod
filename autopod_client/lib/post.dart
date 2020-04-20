import 'dart:async';

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zefyr/zefyr.dart' show NotusDocument;

import './src/client.dart';

class Post {
  int id;
  String title;
  // this should be Json stringified ndoc
  String content;
  DateTime date;
  String hash;
  List<int> mp3;

  Post({this.id, this.title, this.content, this.date, this.hash, this.mp3});

  static Future<Post> fromText(String text) async {
    final content = NotusDocument.fromJson(jsonDecode(text)).toPlainText();
    var post = Post(content: text);
    post.title = content.split('\n')[0].split(' ').take(10).join(' ');
    final bytes = utf8.encode(content);
    post.hash = sha1.convert(bytes).toString();
    post.date = DateTime.now();
    if (content != '') {
      print('text: $content');
      final client = SynthesizeClient();
      post.mp3 = await client.synthesize(content);
    } else {
      post.mp3 = [];
    }
    return post;
  }

  Map<String, dynamic> toMap() {
    var map = {
      'title': title,
      'content': content,
      'date': date.toUtc().millisecondsSinceEpoch,
      'hash': hash,
      'mp3': mp3,
    };
    if (id != null) map['id'] = id;
    return map;
  }

}

class PostDb {
  final String name;
  Database _db;
  static PostDb _instance = PostDb._create();

  PostDb._create({this.name = 'posts'});

  static Future<PostDb> create() async {
    if (_instance._db == null) {
      _instance._db = await openDatabase(
        // Set the path to the database.
        join(await getDatabasesPath(), _instance.name),
        // When the database is first created, create a table to store posts.
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          return db.execute(
            '''CREATE TABLE posts(id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT, content TEXT, date INTEGER, hash TEXT, mp3 BLOB)
            ''',
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 3,
      );
    }
    return _instance;
  }

  Future<Post> insert(Post post) async {
    post.id = await _db.insert('posts', post.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return post;
  }

  Future<List<Post>> listAll() async {
    // Query the table for all The posts.
    final List<Map<String, dynamic>> maps = await _db.query('posts');

    return maps.map((map) => _mapToPost(map)).toList();
  }

  Future<Post> getOrCreateById(int id) async {
    if (id == null) {
      final Delta delta = Delta()..insert('Hello world!\n');
      final post = await Post.fromText(jsonEncode(delta));
      return await insert(post);
    }

    final List<Map<String, dynamic>> maps = await _db.query('posts', where: 'id = ?', whereArgs: [id]);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return maps.map((map) => _mapToPost(map)).first;
  }

  Future<void> update(Post post) async {
    await _db.update('posts', post.toMap(), where: 'id = ?', whereArgs: [post.id]);
  }

  Future<void> delete(int id) async {
    await _db.delete('posts', where: 'id= ?', whereArgs: [id]);
  }

  // private functions
  Post _mapToPost(Map<String, dynamic> map) {
    print('map is $map');
    return Post(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      hash: map['hash'],
      mp3: map['mp3'],
    );
  }
}
