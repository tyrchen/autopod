///
//  Generated code. Do not modify.
//  source: tts.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'tts.pbenum.dart';

export 'tts.pbenum.dart';

class RequestSynthesize extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RequestSynthesize', package: const $pb.PackageName('tts'), createEmptyInstance: create)
    ..aOS(1, 'text')
    ..hasRequiredFields = false
  ;

  RequestSynthesize._() : super();
  factory RequestSynthesize() => create();
  factory RequestSynthesize.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestSynthesize.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RequestSynthesize clone() => RequestSynthesize()..mergeFromMessage(this);
  RequestSynthesize copyWith(void Function(RequestSynthesize) updates) => super.copyWith((message) => updates(message as RequestSynthesize));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestSynthesize create() => RequestSynthesize._();
  RequestSynthesize createEmptyInstance() => create();
  static $pb.PbList<RequestSynthesize> createRepeated() => $pb.PbList<RequestSynthesize>();
  @$core.pragma('dart2js:noInline')
  static RequestSynthesize getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestSynthesize>(create);
  static RequestSynthesize _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);
}

class ResponseSynthesize extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResponseSynthesize', package: const $pb.PackageName('tts'), createEmptyInstance: create)
    ..e<StatusCode>(1, 'code', $pb.PbFieldType.OE, defaultOrMaker: StatusCode.ok, valueOf: StatusCode.valueOf, enumValues: StatusCode.values)
    ..a<$core.List<$core.int>>(2, 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ResponseSynthesize._() : super();
  factory ResponseSynthesize() => create();
  factory ResponseSynthesize.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResponseSynthesize.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ResponseSynthesize clone() => ResponseSynthesize()..mergeFromMessage(this);
  ResponseSynthesize copyWith(void Function(ResponseSynthesize) updates) => super.copyWith((message) => updates(message as ResponseSynthesize));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResponseSynthesize create() => ResponseSynthesize._();
  ResponseSynthesize createEmptyInstance() => create();
  static $pb.PbList<ResponseSynthesize> createRepeated() => $pb.PbList<ResponseSynthesize>();
  @$core.pragma('dart2js:noInline')
  static ResponseSynthesize getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResponseSynthesize>(create);
  static ResponseSynthesize _defaultInstance;

  @$pb.TagNumber(1)
  StatusCode get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(StatusCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
}

class TtsServiceApi {
  $pb.RpcClient _client;
  TtsServiceApi(this._client);

  $async.Future<ResponseSynthesize> synthesize($pb.ClientContext ctx, RequestSynthesize request) {
    var emptyResponse = ResponseSynthesize();
    return _client.invoke<ResponseSynthesize>(ctx, 'TtsService', 'synthesize', request, emptyResponse);
  }
}

