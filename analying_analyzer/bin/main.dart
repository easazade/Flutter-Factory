import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

Future main(List<String> arguments) async {
  final currentPath = Directory('lib/');

  // final children = currentPath.
  print(currentPath.absolute.path);
  final paths = currentPath.listSync().map((e) => e.absolute.path).toList();
  print(paths);
  final collections = AnalysisContextCollection(
    includedPaths: paths,
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  for (var context in collections.contexts) {
    final analyzedFiles = context.contextRoot.analyzedFiles().toList();
    analyzedFiles.sort();

    for (var filePath in analyzedFiles) {
      print(filePath);
      if (!filePath.endsWith('.dart')) {
        continue;
      }

      var library = await context.currentSession.getResolvedLibrary(filePath);
      library as ResolvedLibraryResult;
      var element = library.element;
      var topElements = element.topLevelElements;

      for (final element in topElements) {
        if (element is ClassElement) {
          final elm = element;
          print(elm.thisType);
          print('${element.displayName} - ${element.kind.displayName} - ${elm.thisType}');
          final constructorParams = elm.constructors.first.parameters.toList();
          for (var param in constructorParams) {
            print(
                'constructor param ${param.displayName} - isNullable: ${param.type.isNullable} - isRequired: ${param.isRequired}');
          }
        }
        if (element is FunctionElement) {
          final elm = element;
          print('function name: ${elm.displayName} - params: ${elm.parameters} - returns: ${elm.returnType}');
        }
      }
    }
  }
}

// from `freezed` package
extension DartTypeX on DartType {
  bool get isNullable {
    final that = this;
    if (that is TypeParameterType) {
      return that.bound.isNullable;
    }
    return isDynamic || nullabilitySuffix == NullabilitySuffix.question;
  }
}
