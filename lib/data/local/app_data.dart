import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/data/local/shared_preferences_service.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/data/models/user.dart';

class AppData {
  final _sharedPreferencesService = locator.get<SharedPreferencesService>();
  Future<void> initialize() async {
    currentUser = _sharedPreferencesService.getUser();
  }

  User? currentUser;
  bool get isLoggedIn => currentUser != null;
  List<MedicalTreatment> medicalTreatmentList = [];
  List<User> usersRegister = [];
}
