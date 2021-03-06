// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/dart/element/element.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/resolver.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/summary2/link.dart';
import 'package:analyzer/src/summary2/linked_element_factory.dart';
import 'package:analyzer/src/summary2/reference.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'resynthesize_common.dart';
import 'test_strategies.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ResynthesizeAst2Test);
  });
}

@reflectiveTest
class ResynthesizeAst2Test extends ResynthesizeTestStrategyTwoPhase
    with ResynthesizeTestCases {
  @override
  Future<LibraryElementImpl> checkLibrary(String text,
      {bool allowErrors = false, bool dumpSummaries = false}) async {
    var dartCoreSource = sourceFactory.forUri('dart:core');
    var dartCoreCode = getFile(dartCoreSource.fullName).readAsStringSync();
    dartCoreCode = r'''
abstract class Comparable<T> {
  int compareTo(T other);
}

class Iterable<T> {}

class Iterator<T> {}

class List<T> {}

class Map<K, V> {}

abstract class Null {}

class Object {
  const Object();
}

abstract class String {}

abstract class Type {}

abstract class bool {}

abstract class double extends num {}

abstract class int extends num {}

abstract class num implements Comparable<num> {}
''';

    var rootReference = Reference.root();
    var dartCoreResult = _link(rootReference, dartCoreSource, dartCoreCode);

    var source = addTestSource(text);

    var unit = parseText(text, experimentStatus: experimentStatus);

    // TODO(scheglov) add other libraries
    var libraryUnitMap = {
      source: {source: unit},
    };

    var linkResult = link(
      _FakeAnalysisContext(sourceFactory, null),
      null,
      rootReference,
      [dartCoreResult.bundle],
      libraryUnitMap,
    );

    var rootReference2 = Reference.root();
    var elementFactory = LinkedElementFactory(
      _FakeAnalysisContext(sourceFactory, null),
      null,
      rootReference2,
    );
    elementFactory.addBundle(dartCoreResult.bundle);
    elementFactory.addBundle(linkResult.bundle);
    return elementFactory.elementOfReference(
      rootReference2.getChild('${source.uri}'),
    );
  }

  @override
  @failingTest
  test_class_alias_with_forwarding_constructors() async {
    await super.test_class_alias_with_forwarding_constructors();
  }

  @override
  @failingTest
  test_class_alias_with_forwarding_constructors_type_substitution() async {
    await super
        .test_class_alias_with_forwarding_constructors_type_substitution();
  }

  @override
  @failingTest
  test_class_alias_with_forwarding_constructors_type_substitution_complex() async {
    await super
        .test_class_alias_with_forwarding_constructors_type_substitution_complex();
  }

  @override
  @failingTest
  test_class_constructor_field_formal_functionTyped_noReturnType() async {
    await super
        .test_class_constructor_field_formal_functionTyped_noReturnType();
  }

  @override
  @failingTest
  test_class_constructor_field_formal_functionTyped_withReturnType() async {
    await super
        .test_class_constructor_field_formal_functionTyped_withReturnType();
  }

  @override
  @failingTest
  test_class_constructor_field_formal_multiple_matching_fields() async {
    await super.test_class_constructor_field_formal_multiple_matching_fields();
  }

  @override
  @failingTest
  test_class_constructor_fieldFormal_named_noDefault() async {
    await super.test_class_constructor_fieldFormal_named_noDefault();
  }

  @override
  @failingTest
  test_class_constructor_fieldFormal_named_withDefault() async {
    await super.test_class_constructor_fieldFormal_named_withDefault();
  }

  @override
  @failingTest
  test_class_constructor_fieldFormal_optional_noDefault() async {
    await super.test_class_constructor_fieldFormal_optional_noDefault();
  }

  @override
  @failingTest
  test_class_constructor_fieldFormal_optional_withDefault() async {
    await super.test_class_constructor_fieldFormal_optional_withDefault();
  }

  @override
  @failingTest
  test_class_documented_withMetadata() async {
    await super.test_class_documented_withMetadata();
  }

  @override
  @failingTest
  test_class_setter_invalid_named_parameter() async {
    await super.test_class_setter_invalid_named_parameter();
  }

  @override
  @failingTest
  test_class_setter_invalid_optional_parameter() async {
    await super.test_class_setter_invalid_optional_parameter();
  }

  @override
  @failingTest
  test_class_type_parameters_bound() async {
    await super.test_class_type_parameters_bound();
  }

  @override
  @failingTest
  test_class_type_parameters_f_bound_complex() async {
    await super.test_class_type_parameters_f_bound_complex();
  }

  @override
  @failingTest
  test_class_type_parameters_f_bound_simple() async {
    await super.test_class_type_parameters_f_bound_simple();
  }

  @override
  @failingTest
  test_closure_generic() async {
    await super.test_closure_generic();
  }

  @override
  @failingTest
  test_closure_in_variable_declaration_in_part() async {
    await super.test_closure_in_variable_declaration_in_part();
  }

  @override
  @failingTest
  test_codeRange_class() async {
    await super.test_codeRange_class();
  }

  @override
  @failingTest
  test_codeRange_class_namedMixin() async {
    await super.test_codeRange_class_namedMixin();
  }

  @override
  @failingTest
  test_codeRange_constructor() async {
    await super.test_codeRange_constructor();
  }

  @override
  @failingTest
  test_codeRange_constructor_factory() async {
    await super.test_codeRange_constructor_factory();
  }

  @override
  @failingTest
  test_codeRange_field() async {
    await super.test_codeRange_field();
  }

  @override
  @failingTest
  test_codeRange_field_annotations() async {
    await super.test_codeRange_field_annotations();
  }

  @override
  @failingTest
  test_codeRange_function() async {
    await super.test_codeRange_function();
  }

  @override
  @failingTest
  test_codeRange_method() async {
    await super.test_codeRange_method();
  }

  @override
  @failingTest
  test_codeRange_parameter() async {
    await super.test_codeRange_parameter();
  }

  @override
  @failingTest
  test_codeRange_parameter_annotations() async {
    await super.test_codeRange_parameter_annotations();
  }

  @override
  @failingTest
  test_codeRange_topLevelVariable() async {
    await super.test_codeRange_topLevelVariable();
  }

  @override
  @failingTest
  test_codeRange_topLevelVariable_annotations() async {
    await super.test_codeRange_topLevelVariable_annotations();
  }

  @override
  @failingTest
  test_const_constructor_inferred_args() async {
    await super.test_const_constructor_inferred_args();
  }

  @override
  @failingTest
  test_const_finalField_hasConstConstructor() async {
    await super.test_const_finalField_hasConstConstructor();
  }

  @override
  @failingTest
  test_const_invalid_field_const() async {
    await super.test_const_invalid_field_const();
  }

  @override
  @failingTest
  test_const_invalid_field_final() async {
    await super.test_const_invalid_field_final();
  }

  @override
  @failingTest
  test_const_invalid_topLevel() async {
    await super.test_const_invalid_topLevel();
  }

  @override
  @failingTest
  test_const_invalid_typeMismatch() async {
    await super.test_const_invalid_typeMismatch();
  }

  @override
  @failingTest
  test_const_invokeConstructor_generic_named() async {
    await super.test_const_invokeConstructor_generic_named();
  }

  @override
  @failingTest
  test_const_invokeConstructor_generic_named_imported() async {
    await super.test_const_invokeConstructor_generic_named_imported();
  }

  @override
  @failingTest
  test_const_invokeConstructor_generic_named_imported_withPrefix() async {
    await super
        .test_const_invokeConstructor_generic_named_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_invokeConstructor_generic_noTypeArguments() async {
    await super.test_const_invokeConstructor_generic_noTypeArguments();
  }

  @override
  @failingTest
  test_const_invokeConstructor_generic_unnamed() async {
    await super.test_const_invokeConstructor_generic_unnamed();
  }

  @override
  @failingTest
  test_const_invokeConstructor_generic_unnamed_imported() async {
    await super.test_const_invokeConstructor_generic_unnamed_imported();
  }

  @override
  @failingTest
  test_const_invokeConstructor_generic_unnamed_imported_withPrefix() async {
    await super
        .test_const_invokeConstructor_generic_unnamed_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_invokeConstructor_named() async {
    await super.test_const_invokeConstructor_named();
  }

  @override
  @failingTest
  test_const_invokeConstructor_named_imported() async {
    await super.test_const_invokeConstructor_named_imported();
  }

  @override
  @failingTest
  test_const_invokeConstructor_named_imported_withPrefix() async {
    await super.test_const_invokeConstructor_named_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_invokeConstructor_named_unresolved() async {
    await super.test_const_invokeConstructor_named_unresolved();
  }

  @override
  @failingTest
  test_const_invokeConstructor_named_unresolved3() async {
    await super.test_const_invokeConstructor_named_unresolved3();
  }

  @override
  @failingTest
  test_const_invokeConstructor_named_unresolved4() async {
    await super.test_const_invokeConstructor_named_unresolved4();
  }

  @override
  @failingTest
  test_const_invokeConstructor_named_unresolved6() async {
    await super.test_const_invokeConstructor_named_unresolved6();
  }

  @override
  @failingTest
  test_const_invokeConstructor_unnamed() async {
    await super.test_const_invokeConstructor_unnamed();
  }

  @override
  @failingTest
  test_const_invokeConstructor_unnamed_imported() async {
    await super.test_const_invokeConstructor_unnamed_imported();
  }

  @override
  @failingTest
  test_const_invokeConstructor_unnamed_imported_withPrefix() async {
    await super.test_const_invokeConstructor_unnamed_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_invokeConstructor_unnamed_unresolved2() async {
    await super.test_const_invokeConstructor_unnamed_unresolved2();
  }

  @override
  @failingTest
  test_const_length_ofClassConstField() async {
    await super.test_const_length_ofClassConstField();
  }

  @override
  @failingTest
  test_const_length_ofClassConstField_imported() async {
    await super.test_const_length_ofClassConstField_imported();
  }

  @override
  @failingTest
  test_const_length_ofClassConstField_imported_withPrefix() async {
    await super.test_const_length_ofClassConstField_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_length_ofStringLiteral() async {
    await super.test_const_length_ofStringLiteral();
  }

  @override
  @failingTest
  test_const_length_ofTopLevelVariable() async {
    await super.test_const_length_ofTopLevelVariable();
  }

  @override
  @failingTest
  test_const_length_ofTopLevelVariable_imported() async {
    await super.test_const_length_ofTopLevelVariable_imported();
  }

  @override
  @failingTest
  test_const_length_ofTopLevelVariable_imported_withPrefix() async {
    await super.test_const_length_ofTopLevelVariable_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_length_staticMethod() async {
    await super.test_const_length_staticMethod();
  }

  @override
  @failingTest
  test_const_list_inferredType() async {
    await super.test_const_list_inferredType();
  }

  @override
  @failingTest
  test_const_map_inferredType() async {
    await super.test_const_map_inferredType();
  }

  @override
  @failingTest
  test_const_parameterDefaultValue_initializingFormal_functionTyped() async {
    await super
        .test_const_parameterDefaultValue_initializingFormal_functionTyped();
  }

  @override
  @failingTest
  test_const_parameterDefaultValue_initializingFormal_named() async {
    await super.test_const_parameterDefaultValue_initializingFormal_named();
  }

  @override
  @failingTest
  test_const_parameterDefaultValue_initializingFormal_positional() async {
    await super
        .test_const_parameterDefaultValue_initializingFormal_positional();
  }

  @override
  @failingTest
  test_const_parameterDefaultValue_normal() async {
    await super.test_const_parameterDefaultValue_normal();
  }

  @override
  @failingTest
  test_const_reference_staticField() async {
    await super.test_const_reference_staticField();
  }

  @override
  @failingTest
  test_const_reference_staticField_imported() async {
    await super.test_const_reference_staticField_imported();
  }

  @override
  @failingTest
  test_const_reference_staticField_imported_withPrefix() async {
    await super.test_const_reference_staticField_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_reference_staticMethod() async {
    await super.test_const_reference_staticMethod();
  }

  @override
  @failingTest
  test_const_reference_staticMethod_imported() async {
    await super.test_const_reference_staticMethod_imported();
  }

  @override
  @failingTest
  test_const_reference_staticMethod_imported_withPrefix() async {
    await super.test_const_reference_staticMethod_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_reference_topLevelFunction() async {
    await super.test_const_reference_topLevelFunction();
  }

  @override
  @failingTest
  test_const_reference_topLevelFunction_generic() async {
    await super.test_const_reference_topLevelFunction_generic();
  }

  @override
  @failingTest
  test_const_reference_topLevelFunction_imported() async {
    await super.test_const_reference_topLevelFunction_imported();
  }

  @override
  @failingTest
  test_const_reference_topLevelFunction_imported_withPrefix() async {
    await super.test_const_reference_topLevelFunction_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_reference_topLevelVariable() async {
    await super.test_const_reference_topLevelVariable();
  }

  @override
  @failingTest
  test_const_reference_topLevelVariable_imported() async {
    await super.test_const_reference_topLevelVariable_imported();
  }

  @override
  @failingTest
  test_const_reference_topLevelVariable_imported_withPrefix() async {
    await super.test_const_reference_topLevelVariable_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_reference_type() async {
    await super.test_const_reference_type();
  }

  @override
  @failingTest
  test_const_reference_type_functionType() async {
    await super.test_const_reference_type_functionType();
  }

  @override
  @failingTest
  test_const_reference_type_imported() async {
    await super.test_const_reference_type_imported();
  }

  @override
  @failingTest
  test_const_reference_type_imported_withPrefix() async {
    await super.test_const_reference_type_imported_withPrefix();
  }

  @override
  @failingTest
  test_const_reference_type_typeParameter() async {
    await super.test_const_reference_type_typeParameter();
  }

  @override
  @failingTest
  test_const_reference_unresolved_prefix1() async {
    await super.test_const_reference_unresolved_prefix1();
  }

  @override
  @failingTest
  test_const_reference_unresolved_prefix2() async {
    await super.test_const_reference_unresolved_prefix2();
  }

  @override
  @failingTest
  test_const_topLevel_binary() async {
    await super.test_const_topLevel_binary();
  }

  @override
  @failingTest
  test_const_topLevel_conditional() async {
    await super.test_const_topLevel_conditional();
  }

  @override
  @failingTest
  test_const_topLevel_identical() async {
    await super.test_const_topLevel_identical();
  }

  @override
  @failingTest
  test_const_topLevel_ifNull() async {
    await super.test_const_topLevel_ifNull();
  }

  @override
  @failingTest
  test_const_topLevel_literal() async {
    await super.test_const_topLevel_literal();
  }

  @override
  @failingTest
  test_const_topLevel_parenthesis() async {
    await super.test_const_topLevel_parenthesis();
  }

  @override
  @failingTest
  test_const_topLevel_prefix() async {
    await super.test_const_topLevel_prefix();
  }

  @override
  @failingTest
  test_const_topLevel_throw() async {
    await super.test_const_topLevel_throw();
  }

  @override
  @failingTest
  test_const_topLevel_typedList() async {
    await super.test_const_topLevel_typedList();
  }

  @override
  @failingTest
  test_const_topLevel_typedList_imported() async {
    await super.test_const_topLevel_typedList_imported();
  }

  @override
  @failingTest
  test_const_topLevel_typedList_importedWithPrefix() async {
    await super.test_const_topLevel_typedList_importedWithPrefix();
  }

  @override
  @failingTest
  test_const_topLevel_typedList_typedefArgument() async {
    await super.test_const_topLevel_typedList_typedefArgument();
  }

  @override
  @failingTest
  test_const_topLevel_typedMap() async {
    await super.test_const_topLevel_typedMap();
  }

  @override
  @failingTest
  test_const_topLevel_untypedList() async {
    await super.test_const_topLevel_untypedList();
  }

  @override
  @failingTest
  test_const_topLevel_untypedMap() async {
    await super.test_const_topLevel_untypedMap();
  }

  @override
  @failingTest
  test_constExpr_pushReference_enum_field() async {
    await super.test_constExpr_pushReference_enum_field();
  }

  @override
  @failingTest
  test_constExpr_pushReference_enum_method() async {
    await super.test_constExpr_pushReference_enum_method();
  }

  @override
  @failingTest
  test_constExpr_pushReference_field_simpleIdentifier() async {
    await super.test_constExpr_pushReference_field_simpleIdentifier();
  }

  @override
  @failingTest
  test_constExpr_pushReference_staticMethod_simpleIdentifier() async {
    await super.test_constExpr_pushReference_staticMethod_simpleIdentifier();
  }

  @override
  @failingTest
  test_constructor_initializers_assertInvocation() async {
    await super.test_constructor_initializers_assertInvocation();
  }

  @override
  @failingTest
  test_constructor_initializers_assertInvocation_message() async {
    await super.test_constructor_initializers_assertInvocation_message();
  }

  @override
  @failingTest
  test_constructor_initializers_field() async {
    await super.test_constructor_initializers_field();
  }

  @override
  @failingTest
  test_constructor_initializers_field_notConst() async {
    await super.test_constructor_initializers_field_notConst();
  }

  @override
  @failingTest
  test_constructor_initializers_field_withParameter() async {
    await super.test_constructor_initializers_field_withParameter();
  }

  @override
  @failingTest
  test_constructor_initializers_superInvocation_named() async {
    await super.test_constructor_initializers_superInvocation_named();
  }

  @override
  @failingTest
  test_constructor_initializers_superInvocation_named_underscore() async {
    await super
        .test_constructor_initializers_superInvocation_named_underscore();
  }

  @override
  @failingTest
  test_constructor_initializers_superInvocation_namedExpression() async {
    await super.test_constructor_initializers_superInvocation_namedExpression();
  }

  @override
  @failingTest
  test_constructor_initializers_superInvocation_unnamed() async {
    await super.test_constructor_initializers_superInvocation_unnamed();
  }

  @override
  @failingTest
  test_constructor_initializers_thisInvocation_named() async {
    await super.test_constructor_initializers_thisInvocation_named();
  }

  @override
  @failingTest
  test_constructor_initializers_thisInvocation_namedExpression() async {
    await super.test_constructor_initializers_thisInvocation_namedExpression();
  }

  @override
  @failingTest
  test_constructor_initializers_thisInvocation_unnamed() async {
    await super.test_constructor_initializers_thisInvocation_unnamed();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_named() async {
    await super.test_constructor_redirected_factory_named();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_named_generic() async {
    await super.test_constructor_redirected_factory_named_generic();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_named_imported() async {
    await super.test_constructor_redirected_factory_named_imported();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_named_imported_generic() async {
    await super.test_constructor_redirected_factory_named_imported_generic();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_named_prefixed() async {
    await super.test_constructor_redirected_factory_named_prefixed();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_named_prefixed_generic() async {
    await super.test_constructor_redirected_factory_named_prefixed_generic();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_unnamed() async {
    await super.test_constructor_redirected_factory_unnamed();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_unnamed_generic() async {
    await super.test_constructor_redirected_factory_unnamed_generic();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_unnamed_imported() async {
    await super.test_constructor_redirected_factory_unnamed_imported();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_unnamed_imported_generic() async {
    await super.test_constructor_redirected_factory_unnamed_imported_generic();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_unnamed_prefixed() async {
    await super.test_constructor_redirected_factory_unnamed_prefixed();
  }

  @override
  @failingTest
  test_constructor_redirected_factory_unnamed_prefixed_generic() async {
    await super.test_constructor_redirected_factory_unnamed_prefixed_generic();
  }

  @override
  @failingTest
  test_constructor_redirected_thisInvocation_named() async {
    await super.test_constructor_redirected_thisInvocation_named();
  }

  @override
  @failingTest
  test_constructor_redirected_thisInvocation_named_generic() async {
    await super.test_constructor_redirected_thisInvocation_named_generic();
  }

  @override
  @failingTest
  test_constructor_redirected_thisInvocation_unnamed() async {
    await super.test_constructor_redirected_thisInvocation_unnamed();
  }

  @override
  @failingTest
  test_constructor_redirected_thisInvocation_unnamed_generic() async {
    await super.test_constructor_redirected_thisInvocation_unnamed_generic();
  }

  @override
  @failingTest
  test_constructor_withCycles_const() async {
    await super.test_constructor_withCycles_const();
  }

  @override
  @failingTest
  test_defaultValue_genericFunction() async {
    await super.test_defaultValue_genericFunction();
  }

  @override
  @failingTest
  test_defaultValue_refersToGenericClass_constructor() async {
    await super.test_defaultValue_refersToGenericClass_constructor();
  }

  @override
  @failingTest
  test_defaultValue_refersToGenericClass_constructor2() async {
    await super.test_defaultValue_refersToGenericClass_constructor2();
  }

  @override
  @failingTest
  test_defaultValue_refersToGenericClass_functionG() async {
    await super.test_defaultValue_refersToGenericClass_functionG();
  }

  @override
  @failingTest
  test_defaultValue_refersToGenericClass_methodG() async {
    await super.test_defaultValue_refersToGenericClass_methodG();
  }

  @override
  @failingTest
  test_defaultValue_refersToGenericClass_methodG_classG() async {
    await super.test_defaultValue_refersToGenericClass_methodG_classG();
  }

  @override
  @failingTest
  test_defaultValue_refersToGenericClass_methodNG() async {
    await super.test_defaultValue_refersToGenericClass_methodNG();
  }

  @override
  @failingTest
  test_enum_documented() async {
    await super.test_enum_documented();
  }

  @override
  @failingTest
  test_enum_value_documented() async {
    await super.test_enum_value_documented();
  }

  @override
  @failingTest
  test_enum_values() async {
    await super.test_enum_values();
  }

  @override
  @failingTest
  test_enums() async {
    await super.test_enums();
  }

  @override
  @failingTest
  test_error_extendsEnum() async {
    await super.test_error_extendsEnum();
  }

  @override
  @failingTest
  test_executable_parameter_type_typedef() async {
    await super.test_executable_parameter_type_typedef();
  }

  @override
  @failingTest
  test_export_class() async {
    await super.test_export_class();
  }

  @override
  @failingTest
  test_export_class_type_alias() async {
    await super.test_export_class_type_alias();
  }

  @override
  @failingTest
  test_export_configurations_useDefault() async {
    await super.test_export_configurations_useDefault();
  }

  @override
  @failingTest
  test_export_configurations_useFirst() async {
    await super.test_export_configurations_useFirst();
  }

  @override
  @failingTest
  test_export_configurations_useSecond() async {
    await super.test_export_configurations_useSecond();
  }

  @override
  @failingTest
  test_export_function() async {
    await super.test_export_function();
  }

  @override
  @failingTest
  test_export_getter() async {
    await super.test_export_getter();
  }

  @override
  @failingTest
  test_export_hide() async {
    await super.test_export_hide();
  }

  @override
  @failingTest
  test_export_multiple_combinators() async {
    await super.test_export_multiple_combinators();
  }

  @override
  @failingTest
  test_export_setter() async {
    await super.test_export_setter();
  }

  @override
  @failingTest
  test_export_show() async {
    await super.test_export_show();
  }

  @override
  @failingTest
  test_export_typedef() async {
    await super.test_export_typedef();
  }

  @override
  @failingTest
  test_export_variable() async {
    await super.test_export_variable();
  }

  @override
  @failingTest
  test_export_variable_const() async {
    await super.test_export_variable_const();
  }

  @override
  @failingTest
  test_export_variable_final() async {
    await super.test_export_variable_final();
  }

  @override
  @failingTest
  test_exportImport_configurations_useDefault() async {
    await super.test_exportImport_configurations_useDefault();
  }

  @override
  @failingTest
  test_exportImport_configurations_useFirst() async {
    await super.test_exportImport_configurations_useFirst();
  }

  @override
  @failingTest
  test_exports() async {
    await super.test_exports();
  }

  @override
  @failingTest
  test_field_covariant() async {
    await super.test_field_covariant();
  }

  @override
  @failingTest
  test_field_formal_param_inferred_type_implicit() async {
    await super.test_field_formal_param_inferred_type_implicit();
  }

  @override
  @failingTest
  test_field_inferred_type_nonStatic_implicit_initialized() async {
    await super.test_field_inferred_type_nonStatic_implicit_initialized();
  }

  @override
  @failingTest
  test_field_inferred_type_nonStatic_implicit_uninitialized() async {
    await super.test_field_inferred_type_nonStatic_implicit_uninitialized();
  }

  @override
  @failingTest
  test_field_inferred_type_static_implicit_initialized() async {
    await super.test_field_inferred_type_static_implicit_initialized();
  }

  @override
  @failingTest
  test_field_propagatedType_const_noDep() async {
    await super.test_field_propagatedType_const_noDep();
  }

  @override
  @failingTest
  test_field_propagatedType_final_dep_inLib() async {
    await super.test_field_propagatedType_final_dep_inLib();
  }

  @override
  @failingTest
  test_field_propagatedType_final_dep_inPart() async {
    await super.test_field_propagatedType_final_dep_inPart();
  }

  @override
  @failingTest
  test_field_propagatedType_final_noDep_instance() async {
    await super.test_field_propagatedType_final_noDep_instance();
  }

  @override
  @failingTest
  test_field_propagatedType_final_noDep_static() async {
    await super.test_field_propagatedType_final_noDep_static();
  }

  @override
  @failingTest
  test_field_static_final_untyped() async {
    await super.test_field_static_final_untyped();
  }

  @override
  @failingTest
  test_field_untyped() async {
    await super.test_field_untyped();
  }

  @override
  @failingTest
  test_function_async() async {
    await super.test_function_async();
  }

  @override
  @failingTest
  test_function_asyncStar() async {
    await super.test_function_asyncStar();
  }

  @override
  @failingTest
  test_function_entry_point_in_export() async {
    await super.test_function_entry_point_in_export();
  }

  @override
  @failingTest
  test_function_entry_point_in_export_hidden() async {
    await super.test_function_entry_point_in_export_hidden();
  }

  @override
  @failingTest
  test_function_entry_point_in_part() async {
    await super.test_function_entry_point_in_part();
  }

  @override
  @failingTest
  test_function_parameter_kind_named() async {
    await super.test_function_parameter_kind_named();
  }

  @override
  @failingTest
  test_function_parameter_kind_positional() async {
    await super.test_function_parameter_kind_positional();
  }

  @override
  @failingTest
  test_function_parameter_parameters() async {
    await super.test_function_parameter_parameters();
  }

  @override
  @failingTest
  test_function_parameter_return_type() async {
    await super.test_function_parameter_return_type();
  }

  @override
  @failingTest
  test_function_parameter_return_type_void() async {
    await super.test_function_parameter_return_type_void();
  }

  @override
  @failingTest
  test_function_type_parameter() async {
    await super.test_function_type_parameter();
  }

  @override
  @failingTest
  test_function_type_parameter_with_function_typed_parameter() async {
    await super.test_function_type_parameter_with_function_typed_parameter();
  }

  @override
  @failingTest
  test_function_typed_parameter_implicit() async {
    await super.test_function_typed_parameter_implicit();
  }

  @override
  @failingTest
  test_futureOr() async {
    await super.test_futureOr();
  }

  @override
  @failingTest
  test_futureOr_const() async {
    await super.test_futureOr_const();
  }

  @override
  @failingTest
  test_futureOr_inferred() async {
    await super.test_futureOr_inferred();
  }

  @override
  @failingTest
  test_generic_gClass_gMethodStatic() async {
    await super.test_generic_gClass_gMethodStatic();
  }

  @override
  @failingTest
  test_genericFunction_asFunctionReturnType() async {
    await super.test_genericFunction_asFunctionReturnType();
  }

  @override
  @failingTest
  test_genericFunction_asFunctionTypedParameterReturnType() async {
    await super.test_genericFunction_asFunctionTypedParameterReturnType();
  }

  @override
  @failingTest
  test_genericFunction_asGenericFunctionReturnType() async {
    await super.test_genericFunction_asGenericFunctionReturnType();
  }

  @override
  @failingTest
  test_genericFunction_asMethodReturnType() async {
    await super.test_genericFunction_asMethodReturnType();
  }

  @override
  @failingTest
  test_genericFunction_asParameterType() async {
    await super.test_genericFunction_asParameterType();
  }

  @override
  @failingTest
  test_genericFunction_asTopLevelVariableType() async {
    await super.test_genericFunction_asTopLevelVariableType();
  }

  @override
  @failingTest
  test_getter_inferred_type_nonStatic_implicit_return() async {
    await super.test_getter_inferred_type_nonStatic_implicit_return();
  }

  @override
  @failingTest
  test_import_configurations_useDefault() async {
    await super.test_import_configurations_useDefault();
  }

  @override
  @failingTest
  test_import_configurations_useFirst() async {
    await super.test_import_configurations_useFirst();
  }

  @override
  @failingTest
  test_import_deferred() async {
    await super.test_import_deferred();
  }

  @override
  @failingTest
  test_import_export() async {
    await super.test_import_export();
  }

  @override
  @failingTest
  test_import_hide() async {
    await super.test_import_hide();
  }

  @override
  @failingTest
  test_import_invalidUri_metadata() async {
    await super.test_import_invalidUri_metadata();
  }

  @override
  @failingTest
  test_import_multiple_combinators() async {
    await super.test_import_multiple_combinators();
  }

  @override
  @failingTest
  test_import_prefixed() async {
    await super.test_import_prefixed();
  }

  @override
  @failingTest
  test_import_self() async {
    await super.test_import_self();
  }

  @override
  @failingTest
  test_import_short_absolute() async {
    await super.test_import_short_absolute();
  }

  @override
  @failingTest
  test_import_show() async {
    await super.test_import_show();
  }

  @override
  @failingTest
  test_imports() async {
    await super.test_imports();
  }

  @override
  @failingTest
  test_infer_generic_typedef_simple() async {
    await super.test_infer_generic_typedef_simple();
  }

  @override
  @failingTest
  test_infer_instanceCreation_fromArguments() async {
    await super.test_infer_instanceCreation_fromArguments();
  }

  @override
  @failingTest
  test_infer_property_set() async {
    await super.test_infer_property_set();
  }

  @override
  @failingTest
  test_inference_issue_32394() async {
    await super.test_inference_issue_32394();
  }

  @override
  @failingTest
  test_inference_map() async {
    await super.test_inference_map();
  }

  @override
  @failingTest
  test_inferred_function_type_for_variable_in_generic_function() async {
    await super.test_inferred_function_type_for_variable_in_generic_function();
  }

  @override
  @failingTest
  test_inferred_function_type_in_generic_class_in_generic_method() async {
    await super
        .test_inferred_function_type_in_generic_class_in_generic_method();
  }

  @override
  @failingTest
  test_inferred_function_type_in_generic_closure() async {
    await super.test_inferred_function_type_in_generic_closure();
  }

  @override
  @failingTest
  test_inferred_generic_function_type_in_generic_closure() async {
    await super.test_inferred_generic_function_type_in_generic_closure();
  }

  @override
  @failingTest
  test_inferred_type_is_typedef() async {
    await super.test_inferred_type_is_typedef();
  }

  @override
  @failingTest
  test_inferred_type_refers_to_bound_type_param() async {
    await super.test_inferred_type_refers_to_bound_type_param();
  }

  @override
  @failingTest
  test_inferred_type_refers_to_function_typed_param_of_typedef() async {
    await super.test_inferred_type_refers_to_function_typed_param_of_typedef();
  }

  @override
  @failingTest
  test_inferred_type_refers_to_function_typed_parameter_type_generic_class() async {
    await super
        .test_inferred_type_refers_to_function_typed_parameter_type_generic_class();
  }

  @override
  @failingTest
  test_inferred_type_refers_to_function_typed_parameter_type_other_lib() async {
    await super
        .test_inferred_type_refers_to_function_typed_parameter_type_other_lib();
  }

  @override
  @failingTest
  test_inferred_type_refers_to_method_function_typed_parameter_type() async {
    await super
        .test_inferred_type_refers_to_method_function_typed_parameter_type();
  }

  @override
  @failingTest
  test_inferred_type_refers_to_nested_function_typed_param() async {
    await super.test_inferred_type_refers_to_nested_function_typed_param();
  }

  @override
  @failingTest
  test_inferred_type_refers_to_nested_function_typed_param_named() async {
    await super
        .test_inferred_type_refers_to_nested_function_typed_param_named();
  }

  @override
  @failingTest
  test_inferred_type_refers_to_setter_function_typed_parameter_type() async {
    await super
        .test_inferred_type_refers_to_setter_function_typed_parameter_type();
  }

  @override
  @failingTest
  test_inferredType_definedInSdkLibraryPart() async {
    await super.test_inferredType_definedInSdkLibraryPart();
  }

  @override
  @failingTest
  test_inferredType_implicitCreation() async {
    await super.test_inferredType_implicitCreation();
  }

  @override
  @failingTest
  test_inferredType_implicitCreation_prefixed() async {
    await super.test_inferredType_implicitCreation_prefixed();
  }

  @override
  @failingTest
  test_inferredType_usesSyntheticFunctionType_functionTypedParam() async {
    await super
        .test_inferredType_usesSyntheticFunctionType_functionTypedParam();
  }

  @override
  @failingTest
  test_initializer_executable_with_return_type_from_closure() async {
    await super.test_initializer_executable_with_return_type_from_closure();
  }

  @override
  @failingTest
  test_initializer_executable_with_return_type_from_closure_await_dynamic() async {
    await super
        .test_initializer_executable_with_return_type_from_closure_await_dynamic();
  }

  @override
  @failingTest
  test_initializer_executable_with_return_type_from_closure_await_future3_int() async {
    await super
        .test_initializer_executable_with_return_type_from_closure_await_future3_int();
  }

  @override
  @failingTest
  test_initializer_executable_with_return_type_from_closure_await_future_int() async {
    await super
        .test_initializer_executable_with_return_type_from_closure_await_future_int();
  }

  @override
  @failingTest
  test_initializer_executable_with_return_type_from_closure_await_future_noArg() async {
    await super
        .test_initializer_executable_with_return_type_from_closure_await_future_noArg();
  }

  @override
  @failingTest
  test_initializer_executable_with_return_type_from_closure_field() async {
    await super
        .test_initializer_executable_with_return_type_from_closure_field();
  }

  @override
  @failingTest
  test_instantiateToBounds_boundRefersToEarlierTypeArgument() async {
    await super.test_instantiateToBounds_boundRefersToEarlierTypeArgument();
  }

  @override
  @failingTest
  test_instantiateToBounds_boundRefersToItself() async {
    await super.test_instantiateToBounds_boundRefersToItself();
  }

  @override
  @failingTest
  test_instantiateToBounds_boundRefersToLaterTypeArgument() async {
    await super.test_instantiateToBounds_boundRefersToLaterTypeArgument();
  }

  @override
  @failingTest
  test_instantiateToBounds_functionTypeAlias_reexported() async {
    await super.test_instantiateToBounds_functionTypeAlias_reexported();
  }

  @override
  @failingTest
  test_instantiateToBounds_functionTypeAlias_simple() async {
    await super.test_instantiateToBounds_functionTypeAlias_simple();
  }

  @override
  @failingTest
  test_instantiateToBounds_simple() async {
    await super.test_instantiateToBounds_simple();
  }

  @override
  @failingTest
  test_invalid_annotation_prefixed_constructor() async {
    await super.test_invalid_annotation_prefixed_constructor();
  }

  @override
  @failingTest
  test_invalid_annotation_unprefixed_constructor() async {
    await super.test_invalid_annotation_unprefixed_constructor();
  }

  @override
  @failingTest
  test_invalid_importPrefix_asTypeArgument() async {
    await super.test_invalid_importPrefix_asTypeArgument();
  }

  @override
  @failingTest
  test_invalid_nameConflict_imported() async {
    await super.test_invalid_nameConflict_imported();
  }

  @override
  @failingTest
  test_invalid_nameConflict_imported_exported() async {
    await super.test_invalid_nameConflict_imported_exported();
  }

  @override
  @failingTest
  test_invalid_nameConflict_local() async {
    await super.test_invalid_nameConflict_local();
  }

  @override
  @failingTest
  test_invalid_setterParameter_fieldFormalParameter() async {
    await super.test_invalid_setterParameter_fieldFormalParameter();
  }

  @override
  @failingTest
  test_invalid_setterParameter_fieldFormalParameter_self() async {
    await super.test_invalid_setterParameter_fieldFormalParameter_self();
  }

  @override
  @failingTest
  test_invalidUri_part_emptyUri() async {
    await super.test_invalidUri_part_emptyUri();
  }

  @override
  @failingTest
  test_invalidUris() async {
    await super.test_invalidUris();
  }

  @override
  @failingTest
  test_library_documented_lines() async {
    await super.test_library_documented_lines();
  }

  @override
  @failingTest
  test_library_documented_stars() async {
    await super.test_library_documented_stars();
  }

  @override
  @failingTest
  test_library_name_with_spaces() async {
    await super.test_library_name_with_spaces();
  }

  @override
  @failingTest
  test_library_named() async {
    await super.test_library_named();
  }

  @override
  @failingTest
  test_main_class_alias_via_export() async {
    await super.test_main_class_alias_via_export();
  }

  @override
  @failingTest
  test_main_class_via_export() async {
    await super.test_main_class_via_export();
  }

  @override
  @failingTest
  test_main_getter_via_export() async {
    await super.test_main_getter_via_export();
  }

  @override
  @failingTest
  test_main_typedef() async {
    await super.test_main_typedef();
  }

  @override
  @failingTest
  test_main_typedef_via_export() async {
    await super.test_main_typedef_via_export();
  }

  @override
  @failingTest
  test_main_variable_via_export() async {
    await super.test_main_variable_via_export();
  }

  @override
  @failingTest
  test_member_function_async() async {
    await super.test_member_function_async();
  }

  @override
  @failingTest
  test_member_function_asyncStar() async {
    await super.test_member_function_asyncStar();
  }

  @override
  @failingTest
  test_member_function_syncStar() async {
    await super.test_member_function_syncStar();
  }

  @override
  @failingTest
  test_metadata_classDeclaration() async {
    await super.test_metadata_classDeclaration();
  }

  @override
  @failingTest
  test_metadata_classTypeAlias() async {
    await super.test_metadata_classTypeAlias();
  }

  @override
  @failingTest
  test_metadata_constructor_call_named() async {
    await super.test_metadata_constructor_call_named();
  }

  @override
  @failingTest
  test_metadata_constructor_call_named_prefixed() async {
    await super.test_metadata_constructor_call_named_prefixed();
  }

  @override
  @failingTest
  test_metadata_constructor_call_unnamed() async {
    await super.test_metadata_constructor_call_unnamed();
  }

  @override
  @failingTest
  test_metadata_constructor_call_unnamed_prefixed() async {
    await super.test_metadata_constructor_call_unnamed_prefixed();
  }

  @override
  @failingTest
  test_metadata_constructor_call_with_args() async {
    await super.test_metadata_constructor_call_with_args();
  }

  @override
  @failingTest
  test_metadata_constructorDeclaration_named() async {
    await super.test_metadata_constructorDeclaration_named();
  }

  @override
  @failingTest
  test_metadata_constructorDeclaration_unnamed() async {
    await super.test_metadata_constructorDeclaration_unnamed();
  }

  @override
  @failingTest
  test_metadata_enumConstantDeclaration() async {
    await super.test_metadata_enumConstantDeclaration();
  }

  @override
  @failingTest
  test_metadata_enumDeclaration() async {
    await super.test_metadata_enumDeclaration();
  }

  @override
  @failingTest
  test_metadata_exportDirective() async {
    await super.test_metadata_exportDirective();
  }

  @override
  @failingTest
  test_metadata_fieldDeclaration() async {
    await super.test_metadata_fieldDeclaration();
  }

  @override
  @failingTest
  test_metadata_fieldFormalParameter() async {
    await super.test_metadata_fieldFormalParameter();
  }

  @override
  @failingTest
  test_metadata_fieldFormalParameter_withDefault() async {
    await super.test_metadata_fieldFormalParameter_withDefault();
  }

  @override
  @failingTest
  test_metadata_functionDeclaration_function() async {
    await super.test_metadata_functionDeclaration_function();
  }

  @override
  @failingTest
  test_metadata_functionDeclaration_getter() async {
    await super.test_metadata_functionDeclaration_getter();
  }

  @override
  @failingTest
  test_metadata_functionDeclaration_setter() async {
    await super.test_metadata_functionDeclaration_setter();
  }

  @override
  @failingTest
  test_metadata_functionTypeAlias() async {
    await super.test_metadata_functionTypeAlias();
  }

  @override
  @failingTest
  test_metadata_functionTypedFormalParameter() async {
    await super.test_metadata_functionTypedFormalParameter();
  }

  @override
  @failingTest
  test_metadata_functionTypedFormalParameter_withDefault() async {
    await super.test_metadata_functionTypedFormalParameter_withDefault();
  }

  @override
  @failingTest
  test_metadata_importDirective() async {
    await super.test_metadata_importDirective();
  }

  @override
  @failingTest
  test_metadata_invalid_classDeclaration() async {
    await super.test_metadata_invalid_classDeclaration();
  }

  @override
  @failingTest
  test_metadata_libraryDirective() async {
    await super.test_metadata_libraryDirective();
  }

  @override
  @failingTest
  test_metadata_methodDeclaration_getter() async {
    await super.test_metadata_methodDeclaration_getter();
  }

  @override
  @failingTest
  test_metadata_methodDeclaration_method() async {
    await super.test_metadata_methodDeclaration_method();
  }

  @override
  @failingTest
  test_metadata_methodDeclaration_setter() async {
    await super.test_metadata_methodDeclaration_setter();
  }

  @override
  @failingTest
  test_metadata_partDirective() async {
    await super.test_metadata_partDirective();
  }

  @override
  @failingTest
  test_metadata_prefixed_variable() async {
    await super.test_metadata_prefixed_variable();
  }

  @override
  @failingTest
  test_metadata_simpleFormalParameter() async {
    await super.test_metadata_simpleFormalParameter();
  }

  @override
  @failingTest
  test_metadata_simpleFormalParameter_withDefault() async {
    await super.test_metadata_simpleFormalParameter_withDefault();
  }

  @override
  @failingTest
  test_metadata_topLevelVariableDeclaration() async {
    await super.test_metadata_topLevelVariableDeclaration();
  }

  @override
  @failingTest
  test_metadata_typeParameter_ofClass() async {
    await super.test_metadata_typeParameter_ofClass();
  }

  @override
  @failingTest
  test_metadata_typeParameter_ofClassTypeAlias() async {
    await super.test_metadata_typeParameter_ofClassTypeAlias();
  }

  @override
  @failingTest
  test_metadata_typeParameter_ofFunction() async {
    await super.test_metadata_typeParameter_ofFunction();
  }

  @override
  @failingTest
  test_metadata_typeParameter_ofTypedef() async {
    await super.test_metadata_typeParameter_ofTypedef();
  }

  @override
  @failingTest
  test_method_inferred_type_nonStatic_implicit_param() async {
    await super.test_method_inferred_type_nonStatic_implicit_param();
  }

  @override
  @failingTest
  test_method_inferred_type_nonStatic_implicit_return() async {
    await super.test_method_inferred_type_nonStatic_implicit_return();
  }

  @override
  @failingTest
  test_method_type_parameter() async {
    await super.test_method_type_parameter();
  }

  @override
  @failingTest
  test_method_type_parameter_in_generic_class() async {
    await super.test_method_type_parameter_in_generic_class();
  }

  @override
  @failingTest
  test_method_type_parameter_with_function_typed_parameter() async {
    await super.test_method_type_parameter_with_function_typed_parameter();
  }

  @override
  @failingTest
  test_methodInvocation_implicitCall() async {
    await super.test_methodInvocation_implicitCall();
  }

  @override
  @failingTest
  test_mixin() async {
    await super.test_mixin();
  }

  @override
  @failingTest
  test_mixin_implicitObjectSuperclassConstraint() async {
    await super.test_mixin_implicitObjectSuperclassConstraint();
  }

  @override
  @failingTest
  test_nameConflict_exportedAndLocal() async {
    await super.test_nameConflict_exportedAndLocal();
  }

  @override
  @failingTest
  test_nameConflict_exportedAndLocal_exported() async {
    await super.test_nameConflict_exportedAndLocal_exported();
  }

  @override
  @failingTest
  test_nameConflict_exportedAndParted() async {
    await super.test_nameConflict_exportedAndParted();
  }

  @override
  @failingTest
  test_nameConflict_importWithRelativeUri_exportWithAbsolute() async {
    // TODO(scheglov) unexpectedly passes on Windows
    fail('unexpectedly passes on Windows');
//    await super.test_nameConflict_importWithRelativeUri_exportWithAbsolute();
  }

  @override
  @failingTest
  test_nested_generic_functions_in_generic_class_with_function_typed_params() async {
    await super
        .test_nested_generic_functions_in_generic_class_with_function_typed_params();
  }

  @override
  @failingTest
  test_nested_generic_functions_in_generic_class_with_local_variables() async {
    await super
        .test_nested_generic_functions_in_generic_class_with_local_variables();
  }

  @override
  @failingTest
  test_nested_generic_functions_with_function_typed_param() async {
    await super.test_nested_generic_functions_with_function_typed_param();
  }

  @override
  @failingTest
  test_nested_generic_functions_with_local_variables() async {
    await super.test_nested_generic_functions_with_local_variables();
  }

  @override
  @failingTest
  test_parameter_covariant_inherited() async {
    await super.test_parameter_covariant_inherited();
  }

  @override
  @failingTest
  test_parameter_parameters() async {
    await super.test_parameter_parameters();
  }

  @override
  @failingTest
  test_parameter_parameters_in_generic_class() async {
    await super.test_parameter_parameters_in_generic_class();
  }

  @override
  @failingTest
  test_parameter_return_type() async {
    await super.test_parameter_return_type();
  }

  @override
  @failingTest
  test_parameter_return_type_void() async {
    await super.test_parameter_return_type_void();
  }

  @override
  @failingTest
  test_parameterTypeNotInferred_constructor() async {
    await super.test_parameterTypeNotInferred_constructor();
  }

  @override
  @failingTest
  test_parameterTypeNotInferred_initializingFormal() async {
    await super.test_parameterTypeNotInferred_initializingFormal();
  }

  @override
  @failingTest
  test_parameterTypeNotInferred_staticMethod() async {
    await super.test_parameterTypeNotInferred_staticMethod();
  }

  @override
  @failingTest
  test_parameterTypeNotInferred_topLevelFunction() async {
    await super.test_parameterTypeNotInferred_topLevelFunction();
  }

  @override
  @failingTest
  test_parts() async {
    await super.test_parts();
  }

  @override
  @failingTest
  test_parts_invalidUri() async {
    await super.test_parts_invalidUri();
  }

  @override
  @failingTest
  test_parts_invalidUri_nullStringValue() async {
    await super.test_parts_invalidUri_nullStringValue();
  }

  @override
  @failingTest
  test_setter_inferred_type_nonStatic_implicit_param() async {
    await super.test_setter_inferred_type_nonStatic_implicit_param();
  }

  @override
  @failingTest
  test_syntheticFunctionType_genericClosure() async {
    await super.test_syntheticFunctionType_genericClosure();
  }

  @override
  @failingTest
  test_syntheticFunctionType_genericClosure_inGenericFunction() async {
    await super.test_syntheticFunctionType_genericClosure_inGenericFunction();
  }

  @override
  @failingTest
  test_syntheticFunctionType_inGenericClass() async {
    await super.test_syntheticFunctionType_inGenericClass();
  }

  @override
  @failingTest
  test_syntheticFunctionType_inGenericFunction() async {
    await super.test_syntheticFunctionType_inGenericFunction();
  }

  @override
  @failingTest
  test_syntheticFunctionType_noArguments() async {
    await super.test_syntheticFunctionType_noArguments();
  }

  @override
  @failingTest
  test_syntheticFunctionType_withArguments() async {
    await super.test_syntheticFunctionType_withArguments();
  }

  @override
  @failingTest
  test_type_arguments_implicit() async {
    await super.test_type_arguments_implicit();
  }

  @override
  @failingTest
  test_type_inference_based_on_loadLibrary() async {
    await super.test_type_inference_based_on_loadLibrary();
  }

  @override
  @failingTest
  test_type_inference_closure_with_function_typed_parameter() async {
    await super.test_type_inference_closure_with_function_typed_parameter();
  }

  @override
  @failingTest
  test_type_inference_closure_with_function_typed_parameter_new() async {
    await super.test_type_inference_closure_with_function_typed_parameter_new();
  }

  @override
  @failingTest
  test_type_inference_depends_on_exported_variable() async {
    await super.test_type_inference_depends_on_exported_variable();
  }

  @override
  @failingTest
  test_type_inference_nested_function() async {
    await super.test_type_inference_nested_function();
  }

  @override
  @failingTest
  test_type_inference_nested_function_with_parameter_types() async {
    await super.test_type_inference_nested_function_with_parameter_types();
  }

  @override
  @failingTest
  test_type_inference_of_closure_with_default_value() async {
    await super.test_type_inference_of_closure_with_default_value();
  }

  @override
  @failingTest
  test_type_invalid_topLevelVariableElement_asType() async {
    await super.test_type_invalid_topLevelVariableElement_asType();
  }

  @override
  @failingTest
  test_type_invalid_topLevelVariableElement_asTypeArgument() async {
    await super.test_type_invalid_topLevelVariableElement_asTypeArgument();
  }

  @override
  @failingTest
  test_type_invalid_typeParameter_asPrefix() async {
    await super.test_type_invalid_typeParameter_asPrefix();
  }

  @override
  @failingTest
  test_type_reference_lib_to_lib() async {
    await super.test_type_reference_lib_to_lib();
  }

  @override
  @failingTest
  test_type_reference_lib_to_part() async {
    await super.test_type_reference_lib_to_part();
  }

  @override
  @failingTest
  test_type_reference_part_to_lib() async {
    await super.test_type_reference_part_to_lib();
  }

  @override
  @failingTest
  test_type_reference_part_to_other_part() async {
    await super.test_type_reference_part_to_other_part();
  }

  @override
  @failingTest
  test_type_reference_part_to_part() async {
    await super.test_type_reference_part_to_part();
  }

  @override
  @failingTest
  test_type_reference_to_class_with_type_arguments_implicit() async {
    await super.test_type_reference_to_class_with_type_arguments_implicit();
  }

  @override
  @failingTest
  test_type_reference_to_enum() async {
    await super.test_type_reference_to_enum();
  }

  @override
  @failingTest
  test_type_reference_to_import() async {
    await super.test_type_reference_to_import();
  }

  @override
  @failingTest
  test_type_reference_to_import_export() async {
    await super.test_type_reference_to_import_export();
  }

  @override
  @failingTest
  test_type_reference_to_import_export_export() async {
    await super.test_type_reference_to_import_export_export();
  }

  @override
  @failingTest
  test_type_reference_to_import_export_export_in_subdirs() async {
    await super.test_type_reference_to_import_export_export_in_subdirs();
  }

  @override
  @failingTest
  test_type_reference_to_import_export_in_subdirs() async {
    await super.test_type_reference_to_import_export_in_subdirs();
  }

  @override
  @failingTest
  test_type_reference_to_import_part() async {
    await super.test_type_reference_to_import_part();
  }

  @override
  @failingTest
  test_type_reference_to_import_part2() async {
    await super.test_type_reference_to_import_part2();
  }

  @override
  @failingTest
  test_type_reference_to_import_part_in_subdir() async {
    await super.test_type_reference_to_import_part_in_subdir();
  }

  @override
  @failingTest
  test_type_reference_to_import_relative() async {
    await super.test_type_reference_to_import_relative();
  }

  @override
  @failingTest
  test_type_reference_to_typedef() async {
    await super.test_type_reference_to_typedef();
  }

  @override
  @failingTest
  test_type_reference_to_typedef_with_type_arguments() async {
    await super.test_type_reference_to_typedef_with_type_arguments();
  }

  @override
  @failingTest
  test_type_reference_to_typedef_with_type_arguments_implicit() async {
    await super.test_type_reference_to_typedef_with_type_arguments_implicit();
  }

  @override
  @failingTest
  test_type_unresolved_prefixed() async {
    await super.test_type_unresolved_prefixed();
  }

  @override
  @failingTest
  test_typedef_documented() async {
    await super.test_typedef_documented();
  }

  @override
  @failingTest
  test_typedef_generic() async {
    await super.test_typedef_generic();
  }

  @override
  @failingTest
  test_typedef_generic_asFieldType() async {
    await super.test_typedef_generic_asFieldType();
  }

  @override
  @failingTest
  test_typedef_parameter_parameters() async {
    await super.test_typedef_parameter_parameters();
  }

  @override
  @failingTest
  test_typedef_parameter_parameters_in_generic_class() async {
    await super.test_typedef_parameter_parameters_in_generic_class();
  }

  @override
  @failingTest
  test_typedef_parameter_return_type() async {
    await super.test_typedef_parameter_return_type();
  }

  @override
  @failingTest
  test_typedef_parameter_type() async {
    await super.test_typedef_parameter_type();
  }

  @override
  @failingTest
  test_typedef_parameter_type_generic() async {
    await super.test_typedef_parameter_type_generic();
  }

  @override
  @failingTest
  test_typedef_parameters() async {
    await super.test_typedef_parameters();
  }

  @override
  @failingTest
  test_typedef_parameters_named() async {
    await super.test_typedef_parameters_named();
  }

  @override
  @failingTest
  test_typedef_return_type() async {
    await super.test_typedef_return_type();
  }

  @override
  @failingTest
  test_typedef_return_type_generic() async {
    await super.test_typedef_return_type_generic();
  }

  @override
  @failingTest
  test_typedef_return_type_implicit() async {
    await super.test_typedef_return_type_implicit();
  }

  @override
  @failingTest
  test_typedef_return_type_void() async {
    await super.test_typedef_return_type_void();
  }

  @override
  @failingTest
  test_typedef_type_parameters() async {
    await super.test_typedef_type_parameters();
  }

  @override
  @failingTest
  test_typedef_type_parameters_bound() async {
    await super.test_typedef_type_parameters_bound();
  }

  @override
  @failingTest
  test_typedef_type_parameters_bound_recursive() async {
    await super.test_typedef_type_parameters_bound_recursive();
  }

  @override
  @failingTest
  test_typedef_type_parameters_bound_recursive2() async {
    await super.test_typedef_type_parameters_bound_recursive2();
  }

  @override
  @failingTest
  test_typedef_type_parameters_f_bound_complex() async {
    await super.test_typedef_type_parameters_f_bound_complex();
  }

  @override
  @failingTest
  test_typedef_type_parameters_f_bound_simple() async {
    await super.test_typedef_type_parameters_f_bound_simple();
  }

  @override
  @failingTest
  test_typedef_type_parameters_f_bound_simple_new_syntax() async {
    await super.test_typedef_type_parameters_f_bound_simple_new_syntax();
  }

  @override
  @failingTest
  test_unresolved_annotation_instanceCreation_argument_this() async {
    await super.test_unresolved_annotation_instanceCreation_argument_this();
  }

  @override
  @failingTest
  test_unresolved_annotation_namedConstructorCall_noClass() async {
    await super.test_unresolved_annotation_namedConstructorCall_noClass();
  }

  @override
  @failingTest
  test_unresolved_annotation_namedConstructorCall_noConstructor() async {
    await super.test_unresolved_annotation_namedConstructorCall_noConstructor();
  }

  @override
  @failingTest
  test_unresolved_annotation_prefixedIdentifier_badPrefix() async {
    await super.test_unresolved_annotation_prefixedIdentifier_badPrefix();
  }

  @override
  @failingTest
  test_unresolved_annotation_prefixedIdentifier_noDeclaration() async {
    await super.test_unresolved_annotation_prefixedIdentifier_noDeclaration();
  }

  @override
  @failingTest
  test_unresolved_annotation_prefixedNamedConstructorCall_badPrefix() async {
    await super
        .test_unresolved_annotation_prefixedNamedConstructorCall_badPrefix();
  }

  @override
  @failingTest
  test_unresolved_annotation_prefixedNamedConstructorCall_noClass() async {
    await super
        .test_unresolved_annotation_prefixedNamedConstructorCall_noClass();
  }

  @override
  @failingTest
  test_unresolved_annotation_prefixedNamedConstructorCall_noConstructor() async {
    await super
        .test_unresolved_annotation_prefixedNamedConstructorCall_noConstructor();
  }

  @override
  @failingTest
  test_unresolved_annotation_prefixedUnnamedConstructorCall_badPrefix() async {
    await super
        .test_unresolved_annotation_prefixedUnnamedConstructorCall_badPrefix();
  }

  @override
  @failingTest
  test_unresolved_annotation_prefixedUnnamedConstructorCall_noClass() async {
    await super
        .test_unresolved_annotation_prefixedUnnamedConstructorCall_noClass();
  }

  @override
  @failingTest
  test_unresolved_annotation_simpleIdentifier() async {
    await super.test_unresolved_annotation_simpleIdentifier();
  }

  @override
  @failingTest
  test_unresolved_annotation_unnamedConstructorCall_noClass() async {
    await super.test_unresolved_annotation_unnamedConstructorCall_noClass();
  }

  @override
  @failingTest
  test_unresolved_export() async {
    await super.test_unresolved_export();
  }

  @override
  @failingTest
  test_unresolved_import() async {
    await super.test_unresolved_import();
  }

  @override
  @failingTest
  test_unresolved_part() async {
    await super.test_unresolved_part();
  }

  @override
  @failingTest
  test_unused_type_parameter() async {
    await super.test_unused_type_parameter();
  }

  @override
  @failingTest
  test_variable_getterInLib_setterInPart() async {
    await super.test_variable_getterInLib_setterInPart();
  }

  @override
  @failingTest
  test_variable_getterInPart_setterInLib() async {
    await super.test_variable_getterInPart_setterInLib();
  }

  @override
  @failingTest
  test_variable_getterInPart_setterInPart() async {
    await super.test_variable_getterInPart_setterInPart();
  }

  @override
  @failingTest
  test_variable_propagatedType_final_dep_inLib() async {
    await super.test_variable_propagatedType_final_dep_inLib();
  }

  @override
  @failingTest
  test_variable_propagatedType_final_dep_inPart() async {
    await super.test_variable_propagatedType_final_dep_inPart();
  }

  @override
  @failingTest
  test_variable_propagatedType_implicit_dep() async {
    await super.test_variable_propagatedType_implicit_dep();
  }

  @override
  @failingTest
  test_variable_setterInPart_getterInPart() async {
    await super.test_variable_setterInPart_getterInPart();
  }

  LinkResult _link(Reference root, Source source, String code) {
    var unit = parseText(code, experimentStatus: experimentStatus);

    // TODO(scheglov) add other libraries
    var libraryUnitMap = {
      source: {source: unit},
    };

    var rootReference = Reference.root();
    var linkResult = link(
      _FakeAnalysisContext(sourceFactory, null),
      null,
      rootReference,
      [],
      libraryUnitMap,
    );
    return linkResult;
//    var linkResult = link(rootReference, libraryUnitMap);

//    var libraryLinkResult = linkResult.libraries[source];
//    var defaultUnitResult = libraryLinkResult.units[source];
//
//    var linkedBundleContext = LinkedBundleContext(linkResult.references);
//    var linkedUnitContext = LinkedUnitContext(
//      linkedBundleContext,
//      defaultUnitResult.tokens,
//    );
  }
}

class _FakeAnalysisContext implements AnalysisContext {
  final SourceFactory sourceFactory;
  final Dart2TypeSystem typeSystem;

  _FakeAnalysisContext(this.sourceFactory, this.typeSystem);

  @override
  AnalysisOptions get analysisOptions {
    return AnalysisOptionsImpl();
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
