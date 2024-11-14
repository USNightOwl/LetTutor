import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/sharedpref/constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get accessToken async {
    return _sharedPreference.getString(Preferences.accessToken);
  }

  Future<String?> get refreshToken async {
    return _sharedPreference.getString(Preferences.refreshToken);
  }

  Future<bool> saveAcessToken(String accessToken) async {
    return _sharedPreference.setString(Preferences.accessToken, accessToken);
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    return _sharedPreference.setString(Preferences.refreshToken, refreshToken);
  }

  Future<bool> removeAcessToke() async {
    return _sharedPreference.remove(Preferences.accessToken);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.isLoggedIn) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.isLoggedIn, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.isDarkMode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.isDarkMode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.currentLanguage);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.currentLanguage, language);
  }

  Future<void> saveUser(User user) {
    return _sharedPreference.setString(Preferences.userId, user.id!);
  }

  Future<String?> get userId async {
    return _sharedPreference.getString(Preferences.userId);
  }

  // Locale:-----------------------------------------------------
  String? get locale {
    return _sharedPreference.getString(Preferences.locale);
  }

  Future<void> changeLocale(String locale) {
    return _sharedPreference.setString(Preferences.locale, locale);
  }
}
