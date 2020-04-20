import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:grpc/grpc.dart';
import 'package:path/path.dart' as p;


import 'package:autopod_client/src/gen/tts.pb.dart';
import 'package:autopod_client/src/gen/tts.pbgrpc.dart';

class SynthesizeClient {
  final port;
  final host;

  SynthesizeClient({this.host = 'localhost', this.port = 12345});

  Future<List<int>> synthesize(String text) async {
    final channel = ClientChannel(
          host,
          port: port,
          options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
        );
      final stub = TtsServiceClient(channel);
      try {
        final response = await stub.synthesize(RequestSynthesize()..text = text);
        print('Greeter client received: ${response.code}');
        return response.data;
      } catch (e) {
        print('Caught error: $e');
        throw(e);
      } finally {
        channel.shutdown();
      }
  }

  Future<String> gen(String text, String path) async {
    final bytes = utf8.encode(text);
    final hash = sha1.convert(bytes).toString();
    final filename = p.join(path, "$hash.mp3");
    final file = File(filename);
    if (!await file.exists()) {
      final data = await synthesize(text);
      await file.writeAsBytes(data);
    }
    return filename;
  }
}
