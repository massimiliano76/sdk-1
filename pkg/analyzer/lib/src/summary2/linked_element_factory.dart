// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/element/element.dart';
import 'package:analyzer/src/generated/engine.dart' show AnalysisContext;
import 'package:analyzer/src/summary/idl.dart';
import 'package:analyzer/src/summary2/linked_bundle_context.dart';
import 'package:analyzer/src/summary2/linked_unit_context.dart';
import 'package:analyzer/src/summary2/reference.dart';

class LinkedElementFactory {
  final AnalysisContext analysisContext;
  final AnalysisSession analysisSession;
  final Reference rootReference;
  final Map<String, _Library> libraryMap = {};

  LinkedElementFactory(
      this.analysisContext, this.analysisSession, this.rootReference);

  void addBundle(LinkedNodeBundle bundle, {LinkedBundleContext context}) {
    context ??= LinkedBundleContext(this, bundle.references);
    for (var library in bundle.libraries) {
      libraryMap[library.uriStr] = _Library(context, library);
    }
  }

  LinkedBundleContext bundleContextOfLibrary(String uriStr) {
    return libraryMap[uriStr].context;
  }

  Element elementOfReference(Reference reference) {
    if (reference.element != null) {
      return reference.element;
    }

    return _ElementRequest(this, reference).elementOfReference(reference);
  }

  List<Reference> exportsOfLibrary(String uriStr) {
    var library = libraryMap[uriStr];
    var exportIndexList = library.node.exports;
    var exportReferences = List<Reference>(exportIndexList.length);
    for (var i = 0; i < exportIndexList.length; ++i) {
      var index = exportIndexList[i];
      var reference = library.context.referenceOfIndex(index);
      exportReferences[i] = reference;
    }
    return exportReferences;
  }
}

class _ElementRequest {
  final LinkedElementFactory elementFactory;
  final Reference input;

  _ElementRequest(this.elementFactory, this.input);

  ClassElementImpl createClassElement(
      CompilationUnitElementImpl unit, Reference reference) {
    if (reference.node == null) {
      indexUnitDeclarations(unit);
      assert(reference.node != 0, '$reference');
    }
    return reference.element = ClassElementImpl.forLinkedNode(
      unit,
      reference,
      reference.node,
    );
  }

  LibraryElementImpl createLibraryElement(Reference reference) {
    // TODO(scheglov) use actual values
    var libraryElement = LibraryElementImpl(elementFactory.analysisContext,
        elementFactory.analysisSession, '', -1, 0);

    var uriStr = reference.name;
    var sourceFactory = elementFactory.analysisContext.sourceFactory;
    var libraryData = elementFactory.libraryMap[uriStr];
    var librarySource = sourceFactory.forUri(uriStr);

    var units = <CompilationUnitElementImpl>[];
    var unitContainerRef = reference.getChild('@unit');
    for (var unitData in libraryData.node.units) {
      var unitSource = sourceFactory.forUri(unitData.uriStr);
      var unitElement = CompilationUnitElementImpl.forLinkedNode(
        libraryElement,
        LinkedUnitContext(libraryData.context, unitData.tokens),
        unitContainerRef.getChild(unitData.uriStr),
        unitData.node,
      );
      unitElement.source = unitSource;
      unitElement.librarySource = librarySource;
      units.add(unitElement);
      unitContainerRef.getChild(unitData.uriStr).element = unitElement;
    }

    libraryElement.definingCompilationUnit = units[0];
    libraryElement.parts = units.skip(1).toList();
    return reference.element = libraryElement;
  }

  ElementImpl elementOfReference(Reference reference) {
    if (reference.element != null) {
      return reference.element;
    }

    var parent2 = reference.parent.parent;
    if (parent2 == null) {
      return createLibraryElement(reference);
    }

    var parentName = reference.parent.name;

    if (parentName == '@class') {
      var unit = elementOfReference(parent2);
      return createClassElement(unit, reference);
    }

    if (parentName == '@unit') {
      elementOfReference(parent2);
      // Creating a library fills all its units.
      assert(reference.element != null);
      return reference.element;
    }

    // TODO(scheglov) support other elements
    throw StateError('Not found: $input');
  }

  void indexUnitDeclarations(CompilationUnitElementImpl unit) {
    var context = unit.linkedContext;
    var classRef = unit.reference.getChild('@class');
    for (var declaration in unit.linkedNode.compilationUnit_declarations) {
      var kind = declaration.kind;
      if (kind == LinkedNodeKind.classDeclaration ||
          kind == LinkedNodeKind.classTypeAlias) {
        var name = context.getUnitMemberName(declaration);
        classRef.getChild(name).node = declaration;
      } else {
        // TODO(scheglov) support other elements
        throw UnimplementedError('$kind');
      }
    }
  }
}

class _Library {
  final LinkedBundleContext context;
  final LinkedNodeLibrary node;

  _Library(this.context, this.node);
}
