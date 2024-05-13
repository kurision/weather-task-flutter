import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userStateProvider = StateNotifierProvider<UserNotifier, String?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<String?> {
  UserNotifier() : super(null);
  Future<void> getUserCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final city = prefs.getString('city');
    state = city;
  }

  void setUserCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
    state = city;
  }
}
