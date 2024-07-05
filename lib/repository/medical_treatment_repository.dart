import 'package:make_appointment_app/base/repository/base_repository.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/data/remote/medial_treatment_api.dart';

class MedicalTreatmentRepository extends BaseRepository {
  final AppData _appData;
  final MedicalTreatmentApi _medicalTreatmentApi;

  MedicalTreatmentRepository({
    required MedicalTreatmentApi medicalTreatmentApi,
    required AppData appData,
  })  : _medicalTreatmentApi = medicalTreatmentApi,
        _appData = appData;

  Future<DataResult<List<MedicalTreatment>>>
      getListOfOnlineMedicalTreatment() async {
    return resultWithFuture(
      future: () async {
        final json =
            await _medicalTreatmentApi.getListOfOnlineMedicalTreatment();
        final result = ((json ?? []) as List<dynamic>)
            .map((e) => MedicalTreatment.fromJson(e))
            .toList();
        _appData.medicalTreatmentList = result;
        return result;
      },
    );
  }
}
