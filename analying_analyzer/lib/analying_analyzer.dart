

abstract class Pet {
  Pet({required this.type, required this.says});
  final String type;
  final String says;

  String whatDoesMyPetSay() => says;
}

class Fox extends Pet {
  Fox() : super(type: 'Fox', says: 'Roof Roof roof roof rooroof rooroof');
}

Future<String> method() async {
  return 'nothing';
}
