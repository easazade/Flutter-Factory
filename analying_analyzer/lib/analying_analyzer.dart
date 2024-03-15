import 'package:analying_analyzer/ffd/arg.dart';

abstract class Pet {
  Pet({required this.type, required this.says});
  final String type;
  final String says;

  String whatDoesMyPetSay() => says;
}

class Fox extends Pet {
  Fox({required this.meowObj, this.canFly})
      : super(type: 'Fox', says: 'Roof Roof roof roof rooroof rooroof');

  final bool? canFly;
  final MeowObj meowObj;
}

Future<String> method(String? name) async {
  return name ?? 'nothing';
}
