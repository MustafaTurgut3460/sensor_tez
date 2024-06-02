import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveIntData(int data, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, data);
  }

  static Future<void> saveStringData(String data, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  static Future<int> getIntData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<String> getStringData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var value = prefs.get(key); // get() ile değeri alın
    if (value is String) {
      return value; // Değer String ise döndür
    } else {
      return ""; // Değer String değilse boş String döndür
    }
  }
}
