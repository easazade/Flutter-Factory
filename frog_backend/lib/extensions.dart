// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';

extension RequestContextExt on RequestContext {
  Future<T> readAsync<T extends Object>() => read<Future<T>>();
}
