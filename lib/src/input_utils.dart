// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

class InputUtils {
  /// Converts the given [value] to [type].
  ///
  /// @return [value] converted to [type] or `null` if [value] is `null` or just [value] if conversion failed
  static dynamic convertToType(Type type, dynamic value) {
    print('"$value" is ${value.runtimeType} -> $type');
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
    print('Missing conversion from ${value.runtimeType} $value into type $type');
    return value;
  }

  static dynamic readJson(Map<String, dynamic> json, String path) {
    if (json == null || path == null) {
      return null;
    }
    List<String> keys = path.split('\.');
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
    dynamic result;

    if (key.contains(':')) {
      // --- path element is key:value. List elements must be objects {}
      List<dynamic> keyValue = key.split(":");
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

  ///
  /// Writes the given 'value' at 'path' into the given 'json' map.
  /// If 'path' does not yet exist in the map, it will be created.
  ///
  static Map<String, dynamic> writeJson(
      Map<String, dynamic> json, String path, dynamic value) {
    if (path == null) {
      return json;
    }
    List<String> keys = path.split('\.');
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

  ///
  /// Creates a string from a map by putting each entry into a separate line and
  /// prefixing it with spaces according to its depth within the map.
  ///
  static String prettyPrintMap(Map<dynamic, dynamic> map) {
    return _prettyPrintMap(map, 0);
  }

  static String _prettyPrintMap(Map<dynamic, dynamic> map, int depth) {
    String spaces = '                                   ';
    String prefix = spaces.substring(0, 2 * depth);
    String out = '{\n';
    map.forEach((k, v) {
      out = out + prefix + k + ': ';
      if (v is Map) {
        depth++;
        out = out + _prettyPrintMap(v, depth) + ',\n';
        depth--;
      } else if (v is List) {
        out = out + v.toString() + ',\n';
      } else {
        out = out + v.toString() + ',\n';
      }
    });
    return out + prefix + '}';
  }
}
