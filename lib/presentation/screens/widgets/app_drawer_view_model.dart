import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/data/local/shared_preferences_service.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/repository/auth_repository.dart';

class AppDrawerViewModel extends BaseViewModel {
  final _authRepository = locator.get<AuthRepository>();
  final _sharedPreferencesService = locator.get<SharedPreferencesService>();
  final _appData = locator.get<AppData>();
  late String currentLocale;
  bool get isLoggedIn => _appData.isLoggedIn;
  List<MedicalTreatment> get medicalTreatments => _appData.medicalTreatmentList;

  AppDrawerViewModel() {
    getCurrentLocale();
  }

  void getCurrentLocale() {
    currentLocale = _sharedPreferencesService.getLocale();
    notifyListeners();
  }

  Future<void> logOut() async {
    _sharedPreferencesService.removeToken();
    _sharedPreferencesService.removeUser();
    _appData.currentUser = null;
    handleTask(
      showLoading: false,
      showErrorDialog: false,
      onRequest: () => _authRepository.logOut(),
    );
  }

  Future<void> updateLocale(String locale) async {
    currentLocale = locale;
    LocaleSettings.setLocaleRaw(locale);
    notifyListeners();
    await _sharedPreferencesService.setLocale(locale);
  }
}
