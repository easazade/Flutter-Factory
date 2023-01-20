import 'dart:mirrors';

Future main(List<String> arguments) async {
  final classMirror = reflectClass(Endpoint);
  final instanceMirror = reflect(Endpoint());

  print(instanceMirror);
  printMap(classMirror.instanceMembers);
  printMap(instanceMirror.type.instanceMembers);

  printMap(classMirror.declarations);
  printMap(instanceMirror.type.declarations);
  //
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
