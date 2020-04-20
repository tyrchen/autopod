///
//  Generated code. Do not modify.
//  source: tts.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'tts.pb.dart' as $0;
import 'tts.pbjson.dart';

export 'tts.pb.dart';

abstract class TtsServiceBase extends $pb.GeneratedService {
  $async.Future<$0.ResponseSynthesize> synthesize($pb.ServerContext ctx, $0.RequestSynthesize request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'synthesize': return $0.RequestSynthesize();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'synthesize': return this.synthesize(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TtsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => TtsServiceBase$messageJson;
}

