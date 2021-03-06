import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

List<AnnotatedElement> findAnnotation(Element element, Type annotation) {
  return TypeChecker.fromRuntime(annotation)
      .annotationsOf(element)
      .map((c) => AnnotatedElement(ConstantReader(c), element))
      .toList();
}

Reference referFromAnalyzer(DartType type) {
  return refer(type.name, type.element?.librarySource?.uri?.toString());
}

DartType extractBoundType(DartType type) {
  DartType bound = null;

  if (type is ParameterizedType) {
    if (type.typeArguments.isNotEmpty) {
      bound = type.typeArguments.first;
    }
  }
  return bound;
}

bool isExactlyRuntime(DartType t, Type runtimeType) {
  final streamType = TypeChecker.fromRuntime(runtimeType);
  return  streamType.isExactlyType(t);
}
