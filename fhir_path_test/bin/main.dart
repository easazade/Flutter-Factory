import 'dart:convert';


import 'package:fhir_path/petit/petit_fhir_path.dart';

import 'samples.dart';

void main(List<String> arguments) {
  // print(_runPath(patientSampleResource, patientSampleFhirPath));
  print(_runPath(questionnaireSampleResource, questionnaireSampleFhirPath));
}

String _runPath(String resource, String path) {
  try {
    final resourceJson = jsonDecode(resource) as Map<String, dynamic>;
    final pathResult =
        walkFhirPath(context: resourceJson,resource: resourceJson, pathExpression: path);
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonDecode(jsonEncode(pathResult)));
  } catch (e) {
    return e.toString();
  }
}
