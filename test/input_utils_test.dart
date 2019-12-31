import 'package:flutter_input/flutter_input.dart';
import 'package:test/test.dart';

void main() {
  // --- Preparations
  Map<String, dynamic> json = {
    'key0': 'root-string',
    'key1': {'sub1': 'node-string'},
    'key2': ['listVal0', 'listVal1', 'listVal2'],
    'key3': [
      {'id': 7, 'sub1': 'value7-1'},
      {'id': 8, 'sub1': 'value8-1'}
    ],
  };

  print(InputUtils.prettyPrintMap(json));
  testReadFromMap(json);
  testWriteToMap(json);
}

void testReadFromMap(Map<String, dynamic> json) {
  group('Reading from JSON map', () {
    String path = 'key0';
    test(path, () {
      expect(InputUtils.readJson(json, path), equals('root-string'));
    });
    path = 'key1.sub1';
    test(path, () {
      expect(InputUtils.readJson(json, path), equals('node-string'));
    });
    path = 'key1.1';
    test(path, () {
      expect(InputUtils.readJson(json, path), equals('listVal1'));
    });
    path = 'key3.id:7';
    test(path, () {
      expect(InputUtils.readJson(json, path), equals({'id': 7, 'sub1': 'value7-1'}));
    });
    path = 'key3.id:8.sub1';
    test(path, () {
      expect(InputUtils.readJson(json, path), equals('value8-1'));
    });
  });
}

void testWriteToMap(Map<String, dynamic> json) {
  group('Writing into existing JSON map', () {
    String path = 'key1.sub1', value = 'new value';
    test(path, () {
      expect(InputUtils.writeJson(json, path, value), equals(json));
    });
  });
}
