import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
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

      for (var element in topElements) {
        print('${element.displayName} - ${element.kind.displayName}');
      }
    }
  }
}
