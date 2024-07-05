import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/repository/medical_treatment_repository.dart';

class HomeViewModel extends BaseViewModel {
  final _appData = locator.get<AppData>();
  final _medicalTreatmentRepository = locator.get<MedicalTreatmentRepository>();
  bool get isLoggedIn => _appData.isLoggedIn;
  List<MedicalTreatment> medicalTreatmentList = [];
  HomeViewModel() {
    getMedicalTreatmentList();
  }

  Future<void> getMedicalTreatmentList() async {
    await handleTask(
      onRequest: () =>
          _medicalTreatmentRepository.getListOfOnlineMedicalTreatment(),
      onSuccess: (data) {
        medicalTreatmentList = data;
        notifyListeners();
      },
    );
  }
}
