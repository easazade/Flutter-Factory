import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:package_config/package_config.dart';
import 'package:source_gen/source_gen.dart';
import 'package:path/path.dart' as path;

Future main(List<String> arguments) async {
  // await _readLibUsingAnalyzer();
  await _readGetItPackageUsingAnalyzer();
}

Future<void> _readLibUsingAnalyzer() async {
  final currentPath = Directory('lib/');

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
      if (library is! ResolvedLibraryResult) {
        return;
      }
      var element = library.element;
      var topElements = element.topLevelElements;

      for (final element in topElements) {
        if (element is ClassElement) {
          final elm = element;
          print(elm.thisType);
          print(
              '${element.displayName} - ${element.kind.displayName} - ${elm.thisType}');
          final constructorParams = elm.constructors.first.parameters.toList();
          for (var param in constructorParams) {
            print(
                'constructor param ${param.displayName} - isNullable: ${param.type.isNullable} - isRequired: ${param.isRequired}');
          }
        }
        if (element is FunctionElement) {
          final elm = element;
          print(
              'function name: ${elm.displayName} - params: ${elm.parameters} - returns: ${elm.returnType}');
        }
      }
    }
  }
}

/// this function reads an external package called get_it using analyzer
Future<void> _readGetItPackageUsingAnalyzer() async {
  // final collections =
      // getAnalysisContextCollectionForPackage(package: 'flutter');
  final collections =
      await getAnalysisContextCollectionForPackage(package: 'get_it');

  for (var context in collections.contexts) {
    final analyzedFiles = context.contextRoot.analyzedFiles().toList();
    analyzedFiles.sort();

    for (var filePath in analyzedFiles) {
      print(filePath);
      if (!filePath.endsWith('.dart')) {
        continue;
      }

      var library = await context.currentSession.getResolvedLibrary(filePath);
      if (library is! ResolvedLibraryResult) {
        return;
      }
      var element = library.element;
      var topElements = element.topLevelElements;

      for (final element in topElements) {
        if (element is ClassElement) {
          final elm = element;
          print(elm.thisType);
          print(
              '${element.displayName} - ${element.kind.displayName} - ${elm.thisType}');
          final constructorParams = elm.constructors.first.parameters.toList();
          for (var param in constructorParams) {
            print(
                'constructor param ${param.displayName} - isNullable: ${param.type.isNullable} - isRequired: ${param.isRequired}');
          }
        }
        if (element is FunctionElement) {
          final elm = element;
          print(
              'function name: ${elm.displayName} - params: ${elm.parameters} - returns: ${elm.returnType}');
        }
      }
    }
  }
}

Future<AnalysisContextCollection> getAnalysisContextCollectionForPackage({
  required String package,
  String? dartFilePath,
}) async {
  var packageConfig = await loadPackageConfigUri(Uri.base.resolve('.packages'));

  var getItPackageUri = packageConfig[package]!.packageUriRoot;
  // var getItPackageUri = packageConfig['get_it']!.packageUriRoot;

  print('path -> ${getItPackageUri.toString()}');
  final filePath = getItPackageUri.toFilePath();
  print('filePath -> $filePath');
  final absolutePath = File(filePath).absolute.path;
  print('absolutePath -> $absolutePath');
  final finalPath = path.normalize('$absolutePath/${dartFilePath ?? ""}');
  print('final normalized path of file -> $finalPath');

  final collections = AnalysisContextCollection(
    includedPaths: [finalPath],
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  return collections;
}


// from `freezed` package
extension DartTypeX on DartType {
  bool get isNullable {
    final that = this;
    if (that is TypeParameterType) {
      return that.bound.isNullable;
    }
    return this is DynamicType ||
        nullabilitySuffix == NullabilitySuffix.question;
  }
}
