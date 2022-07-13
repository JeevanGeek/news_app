import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._();

  static const String country = "country";
  static const String countryCode = "countryCode";

  static late SharedPreferences preference;

  static Future init() async {
    preference = await SharedPreferences.getInstance();
  }

  static Future setCountry(String country) async {
    await preference.setString(country, country);
  }

  static String getCountry() {
    return preference.getString(country) ?? "";
  }

  static Future setCountryCode(String countryCode) async {
    await preference.setString(countryCode, countryCode);
  }

  static String getCountryCode() {
    return preference.getString(countryCode) ?? "";
  }
}
