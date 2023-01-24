import 'package:shared_preferences/shared_preferences.dart';

import 'key.dart';

class Services {
  static Future<bool> create(String data) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(kStringListKey) ?? [];
    final newList = [...list, data];
    prefs.setStringList(kStringListKey, newList);
    return true;
  }

  static Future<bool> delete(String data) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(kStringListKey) ?? [];
    list.remove(data);
    prefs.setStringList(kStringListKey, list);
    return true;
  }

  static Future<List<String>> todos() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(kStringListKey);
    return list ?? [];
  }
}
