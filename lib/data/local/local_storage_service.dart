import 'package:shared_preferences/shared_preferences.dart';

final class LocalStorageService {
  late final SharedPreferences sharedPreferences;

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
