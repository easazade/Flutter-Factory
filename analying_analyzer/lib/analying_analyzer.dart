abstract class Pet {
  Pet({required this.type, required this.says});
  final String type;
  final String says;

  String whatDoesMyPetSay() => says;
}

class Fox extends Pet {
  Fox({this.canFly}) : super(type: 'Fox', says: 'Roof Roof roof roof rooroof rooroof');

  final bool? canFly;
}

Future<String> method(String? name) async {
  return name ?? 'nothing';
}
