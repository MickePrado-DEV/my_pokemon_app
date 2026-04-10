import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserRepository {
  static const String _nameKey = 'trainer_name';
  static const String _genderKey = 'trainer_gender';
  static const String _regKey = 'is_registered';

  Future<void> saveUser(String name, Gender gender) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_genderKey, gender.name); // male, female o none
    await prefs.setBool(_regKey, true);
  }

  Future<UserProfile?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString(_nameKey);
    final String? genderStr = prefs.getString(_genderKey);
    final bool? isReg = prefs.getBool(_regKey);

    if (isReg == true && name != null && genderStr != null) {
      final gender = Gender.values.byName(genderStr);
      return UserProfile(name: name, gender: gender);
    }
    return null;
  }
}