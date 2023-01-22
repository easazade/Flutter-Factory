import 'dart:mirrors';

import 'package:reflection_learn/reflection_learn.dart';

Future main(List<String> arguments) async {
  var1; //just using
  ClassMirror;

  // currentMirrorSystem().isolate.rootLibrary.declarations.entries.forEach((element) {
  //   print(element);
  // });

  currentMirrorSystem().libraries.values.forEach((libMirror) {
    if (libMirror.uri == Uri.parse('package:reflection_learn/top_level.dart')) {
      for (var element in libMirror.declarations.entries) {
        final DeclarationMirror var1 = element.value;
        print(var1.simpleName);
        print(libMirror.getField(var1.simpleName).reflectee);
        // final varMirror = var1 as VariableMirror;
        // print(var1);
      }
    }
  });

  // currentMirrorSystem().libraries.values.forEach((libMirror) {
  //   if (libMirror.uri == Uri.parse('package:reflection_learn/top_level.dart')) {
  //     final f = libMirror.getField(#var1);
  //     print(f.reflectee);
  //     // for (var element in libMirror.declarations.entries) {
  //     //   final DeclarationMirror var1 = element.value;
  //     //   final varMirror = var1 as VariableMirror;
  //     //   print(var1);
  //     // }
  //   }
  // });

  // final classMirror = reflectClass(Endpoint);

  // final instanceMirror = reflect(Endpoint());

  // print(instanceMirror);
  // printMap(classMirror.instanceMembers);
  // printMap(instanceMirror.type.instanceMembers);

  // printMap(classMirror.declarations);
  // printMap(instanceMirror.type.declarations);
  // final reflectee = instanceMirror.reflectee;
  // print(reflectee);

  // print(instanceMirror.type.location);

  // instanceMirror.invoke(Symbol('handle'), []);
  // instanceMirror.invoke(#handle, []); //short hand handle
}

void printMap(Map map) {
  print('==========================================');
  for (var entry in map.entries) {
    print('${entry.key} : ${entry.value}');
  }
  print('==========================================');
}

class Endpoint {
  final whatever = 'object';
  var name = 'reza';
  var age = 29;

  void handle() => print('Request received');
}

final name = 'zereshk';
