// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

/// Provides utility methods used by package `flutter_input`:
/// * [convertToType] converts a value to a target type (if possible)
/// * [readJson] allows reading from a nested map using a dotted string
/// * [writeJson] allows writing into a nested map using a dotted string
/// * [prettyPrintMap] prints a map with one entry per line
class InputUtils {
  /// Converts [value] to [type].
  ///
  /// Returns `null` if [value] is `null` else [value] converted to [type]
  /// or just [value] if conversion failed.
  static dynamic convertToType(Type type, dynamic value) {
    if (value == null) {
      return null;
    }
    if (type == value.runtimeType) {
      return value;
    }
    if (type == String) {
      return value.toString();
    }
    if (type == bool) {
      if (value.runtimeType == String) {
        String strVal = value;
        if (strVal.toLowerCase() == 'true' || strVal == '1') {
          return true;
        }
        return false;
      }
    } else if (type == int) {
      if (value.runtimeType == String) {
        return int.tryParse(value);
      } else if (value.runtimeType == double) {
        double dval = value;
        return dval.floor();
      }
    } else if (type == double) {
      if (value.runtimeType == int) {
        int intVal = value;
        return intVal.toDouble();
      } else if (value.runtimeType == String) {
        return double.parse(value);
      }
    } else if (type == DateTime) {
      if (value.runtimeType == String) {
        return DateTime.parse(value);
      }
    }
    print(
        'Missing conversion from ${value.runtimeType} $value into type $type');
    return value;
  }

  /// Reads a value from a nested map (`json`). The map is identified by a
  /// slash (`/`) separated `path`.
  ///
  /// ```dart
  /// Map<String, dynamic> json = { 'user' : { 'name' : 'Hajo', 'bday' : '1964-09-21' },};
  /// DateTime birthday = Datetime.parse( readJson( json, 'user/bday' ));
  /// ```
  static dynamic readJson(Map<String, dynamic> json, String path) {
    if (json == null || path == null) {
      return null;
    }
    List<String> keys = path.split('/');
    dynamic value = json;
    for (int i = 0; i < keys.length; i++) {
      if (value == null) return null;
      try {
        if (value is List) {
          // --- json element is a list [...]
          value = _readJsonFromList(value, keys[i]);
        } else {
          // --- json element is a value or an object {}
          value = value[keys[i]];
        }
      } catch (e) {
        print('path=$path i=$i value=$value -> ' + e.toString());
      }
    }
    return value;
  }

  static dynamic _readJsonFromList(List<dynamic> list, String key) {
    if (key.contains(':')) {
      // --- path element is key:value. List elements must be objects {}
      List<dynamic> keyValue = key.split(':');
      String k = keyValue[0];
      String v = keyValue[1];
      Map<String, dynamic> entry;
      // --- Scan objects in list
      for (int i = 0; i < list.length; i++) {
        entry = list[i];
        if (entry[k].toString() == v) {
          return entry;
        }
      }
    } else {
      // --- path element is the integer index
      int j = int.parse(key);
      return list[j];
    }
    return null;
  }

  /// Writes the given `value` at `path` into the given `json` map.
  /// If `path` does not yet exist in the map, it will be created.
  static Map<String, dynamic> writeJson(
      Map<String, dynamic> json, String path, dynamic value) {
    if (path == null) {
      return json;
    }
    List<String> keys = path.split('/');
    // --- new map with last key : value
    Map<String, dynamic> map = {keys[keys.length - 1]: value};
    for (int i = keys.length - 2; i >= 0; i--) {
      map = {keys[i]: map};
    }
    if (json == null) {
      return map;
    }
    Map<String, dynamic> innerJson = json;
    for (int i = 0; i < keys.length; i++) {
      if (innerJson.containsKey(keys[i]) && innerJson[keys[i]] is Map) {
        innerJson = innerJson[keys[i]];
        map = map[keys[i]];
      } else {
        innerJson.addAll(map);
        break;
      }
    }
    return json;
  }

  /// Creates a string from a map by putting each entry on a separate line and
  /// prefixing it with spaces according to its depth within the map.
  static String prettyPrintMap(Map<dynamic, dynamic> map) {
    return _prettyPrintMap(map, 0);
  }

  static final String _spaces = '                                   ';

  static String _prettyPrintList(List<dynamic> list, int depth) {
    String _indent = _spaces.substring(0, 2 * depth);
    depth++;
    String out = '[\n';
    list.forEach((element) {
      out = out + _indent;
      print('_printList( element=$element is ${element.runtimeType}');
      if (element is Map) {
        out = out + _prettyPrintMap(element, depth) + ',\n';
      } else if (element is List) {
        out = out + _prettyPrintList(element, depth) + ',\n';
      } else {
        out = out + element.toString() + ',\n';
      }
    });
    depth--;
    return out + _indent + ']';
  }

  static String _prettyPrintMap(Map<dynamic, dynamic> map, int depth) {
    String _indent = _spaces.substring(0, 2 * depth);
    depth++;
    String out = '{\n';
    map.forEach((k, v) {
      out = out + _indent + k + ': ';
      if (v is Map) {
        out = out + _prettyPrintMap(v, depth) + ',\n';
      } else if (v is List) {
        out = out + _prettyPrintList(v, depth);
      } else {
        out = out + v.toString() + ',\n';
      }
    });
    depth--;
    return out + _indent + '}';
  }
}
