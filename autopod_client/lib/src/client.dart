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

  Future<String> gen(String text, String path) async {
    final bytes = utf8.encode(text);
    final filename = p.join(path, "${sha1.convert(bytes)}.mp3");
    final file = File(filename);
    if (!await file.exists()) {
      final channel = ClientChannel(
          host,
          port: port,
          options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
        );
      final stub = TtsServiceClient(channel);
      try {
        final response = await stub.synthesize(RequestSynthesize()..text = text);
        await file.writeAsBytes(response.data);
        print('Greeter client received: ${response.code}');
      } catch (e) {
        print('Caught error: $e');
      }
      channel.shutdown();
    }
    return filename;
  }
}
