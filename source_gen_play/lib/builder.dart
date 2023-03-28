import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder player(BuilderOptions options) {
  return LibraryBuilder(
    PlayerGenerator(),
    header: '/// THIS IS THE FILE HEADER. DO NOT MODIFY THIS FILE MANUALLY\n\n',
  );
}

class PlayerGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    return '/// this is the generated content of the file';
  }
}
