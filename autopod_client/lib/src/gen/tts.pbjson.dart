///
//  Generated code. Do not modify.
//  source: tts.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const StatusCode$json = const {
  '1': 'StatusCode',
  '2': const [
    const {'1': 'ok', '2': 0},
  ],
};

const RequestSynthesize$json = const {
  '1': 'RequestSynthesize',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
  ],
};

const ResponseSynthesize$json = const {
  '1': 'ResponseSynthesize',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 14, '6': '.tts.StatusCode', '10': 'code'},
    const {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

const TtsServiceBase$json = const {
  '1': 'TtsService',
  '2': const [
    const {'1': 'synthesize', '2': '.tts.RequestSynthesize', '3': '.tts.ResponseSynthesize'},
  ],
};

const TtsServiceBase$messageJson = const {
  '.tts.RequestSynthesize': RequestSynthesize$json,
  '.tts.ResponseSynthesize': ResponseSynthesize$json,
};

