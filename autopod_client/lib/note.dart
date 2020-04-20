import 'package:meta/meta.dart';

class Note {
  Note({
    @required this.title,
    @required this.text,
    @required this.date,
  });

  final String title;
  String text;
  final DateTime date;
}
