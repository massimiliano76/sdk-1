// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/source/sdk_ext.dart';
import 'package:analyzer/src/test_utilities/resource_provider_mixin.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SdkExtUriResolverTest);
  });
}

@reflectiveTest
class SdkExtUriResolverTest with ResourceProviderMixin {
  void setUp() {
    String joinAndEscape(List<String> components) {
      return resourceProvider.pathContext
          .joinAll(components)
          .replaceAll(r'\', r'\\');
    }

    newFolder('/empty');
    newFolder('/tmp');
    newFile('/tmp/_sdkext', content: '''
{
  "dart:fox": "slippy.dart",
  "dart:bear": "grizzly.dart",
  "dart:relative": "${joinAndEscape(['..', 'relative.dart'])}",
  "dart:deep": "${joinAndEscape(['deep', 'directory', 'file.dart'])}",
  "fart:loudly": "nomatter.dart"
}''');
  }

  test_create_badJSON() {
    var resolver = new SdkExtUriResolver(null);
    resolver.addSdkExt(r'''{{{,{{}}},}}''', null);
    expect(resolver.length, 0);
  }

  test_create_noSdkExtPackageMap() {
    var resolver = new SdkExtUriResolver({
      'fox': <Folder>[getFolder('/empty')]
    });
    expect(resolver.length, 0);
  }

  test_create_nullPackageMap() {
    var resolver = new SdkExtUriResolver(null);
    expect(resolver.length, 0);
  }

  test_create_sdkExtPackageMap() {
    var resolver = new SdkExtUriResolver({
      'fox': <Folder>[newFolder('/tmp')]
    });
    // We have four mappings.
    expect(resolver.length, 4);
    // Check that they map to the correct paths.
    expect(resolver['dart:fox'], convertPath('/tmp/slippy.dart'));
    expect(resolver['dart:bear'], convertPath('/tmp/grizzly.dart'));
    expect(resolver['dart:relative'], convertPath('/relative.dart'));
    expect(resolver['dart:deep'], convertPath('/tmp/deep/directory/file.dart'));
  }

  test_restoreAbsolute() {
    var resolver = new SdkExtUriResolver({
      'fox': <Folder>[newFolder('/tmp')]
    });
    var source = resolver.resolveAbsolute(Uri.parse('dart:fox'));
    expect(source, isNotNull);
    // Restore source's uri.
    var restoreUri = resolver.restoreAbsolute(source);
    expect(restoreUri, isNotNull);
    // Verify that it is 'dart:fox'.
    expect(restoreUri.toString(), 'dart:fox');
    expect(restoreUri.scheme, 'dart');
    expect(restoreUri.path, 'fox');
  }
}
