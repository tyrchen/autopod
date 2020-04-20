///
//  Generated code. Do not modify.
//  source: tts.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tts.pb.dart' as $0;
export 'tts.pb.dart';

class TtsServiceClient extends $grpc.Client {
  static final _$synthesize =
      $grpc.ClientMethod<$0.RequestSynthesize, $0.ResponseSynthesize>(
          '/tts.TtsService/synthesize',
          ($0.RequestSynthesize value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ResponseSynthesize.fromBuffer(value));

  TtsServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.ResponseSynthesize> synthesize(
      $0.RequestSynthesize request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$synthesize, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class TtsServiceBase extends $grpc.Service {
  $core.String get $name => 'tts.TtsService';

  TtsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequestSynthesize, $0.ResponseSynthesize>(
        'synthesize',
        synthesize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestSynthesize.fromBuffer(value),
        ($0.ResponseSynthesize value) => value.writeToBuffer()));
  }

  $async.Future<$0.ResponseSynthesize> synthesize_Pre($grpc.ServiceCall call,
      $async.Future<$0.RequestSynthesize> request) async {
    return synthesize(call, await request);
  }

  $async.Future<$0.ResponseSynthesize> synthesize(
      $grpc.ServiceCall call, $0.RequestSynthesize request);
}
