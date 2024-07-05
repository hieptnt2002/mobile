import 'package:make_appointment_app/base/data/remote/api.dart';

class MedicalTreatmentApi {
  Future<dynamic> getListOfOnlineMedicalTreatment() async {
    return Api.request(
      httpMethod: HttpMethod.get,
      url: '/user/services',
    );
  }
}
