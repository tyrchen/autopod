import 'package:autopod_client/src/client.dart';

Future<void> main(List<String> args) async {
  final client = SynthesizeClient();

  final text = '''
  It was, he thought, the difference between being dragged into the arena to face a battle to the death and walking into the arena with your head held high. Some people, perhaps, would say that there was little to choose between the two ways, but Dumbledore knew — and so do I, thought Harry, with a rush of fierce pride, and so did my parents — that there was all the difference in the world.
  ''';

  final filename = await client.gen(text, '/tmp');
  print('generated file: $filename');

}
