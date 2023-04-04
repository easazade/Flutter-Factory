import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder player(BuilderOptions options) {
  return LibraryBuilder(
    PlayerGenerator(),
    generatedExtension: '.player.dart',
    header: '/// THIS IS THE FILE HEADER. DO NOT MODIFY THIS FILE MANUALLY\n\n',
    options: options,
  );
}

class PlayerGenerator extends Generator {
  int _counter = 0;

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) {
    print('--------------------------------------------------------');
    for (var element in library.classes) {
      print('${element.displayName} - ${element.runtimeType}');
      for (var child in element.children) {
        print('${child.displayName} - ${child.runtimeType}');
      }
    }
    print('--------------------------------------------------------');

    // for (var element in library.allElements) {
    //   if (element is LibraryElement)
    //     for (var child in element.children) {
    //       if (child is CompilationUnitElement) {
    //         print('${child.runtimeType} ----------');
    //       }
    //     }
    // }

    // final libraryElement = library.element;
    // final parsedLibraryResult = libraryElement.session.getParsedLibraryByElement(libraryElement) as ParsedLibraryResult;

    // final libraryCompilationUnit = parsedLibraryResult.units[0].unit;

    // final selectorInstantiationLocator = SelectorInstantiationLocator();
    // libraryCompilationUnit.visitChildren(selectorInstantiationLocator);

    // final selectorInstantiations = selectorInstantiationLocator.selectorInstantiations;

    // print(selectorInstantiations.keys);
    // return null;
    return '/// this is the generated content of the file';
  }
}

class SelectorInstantiationLocator extends RecursiveAstVisitor<void> {
  final selectorInstantiations = <String, MethodInvocation>{};

  @override
  void visitMethodInvocation(MethodInvocation node) {
    // Ensure that the invocation is an appropriate target for code generation.
    // &= is not used in favour of the short-circuit && operator (https://github.com/dart-lang/language/issues/23).

    // Stop if the invocation doesn't match the required prefix.
    final className = node.methodName.name;
    var isSelectorInstantiation = className.startsWith(r'_$$');
    final classIndex = int.tryParse(className.substring(3));
    isSelectorInstantiation = isSelectorInstantiation && (classIndex != null && classIndex >= 0);
    // No target will exist for a constructor invocation.
    isSelectorInstantiation = isSelectorInstantiation && node.realTarget == null;
    // The selector instantiation should be done in an expression function body (=>).
    isSelectorInstantiation = isSelectorInstantiation && node.parent is ExpressionFunctionBody;
    // The function body should be part of a function expression (rather than a method declaration)
    isSelectorInstantiation = isSelectorInstantiation && node.parent!.parent is FunctionExpression;
    // The function expression should be inside an argument list.
    isSelectorInstantiation = isSelectorInstantiation && node.parent!.parent!.parent is ArgumentList;

    if (isSelectorInstantiation) selectorInstantiations[className] = node;

    return super.visitMethodInvocation(node);
  }
}
