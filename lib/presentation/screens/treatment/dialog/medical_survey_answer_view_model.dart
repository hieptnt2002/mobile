import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/repository/medical_survey_repository.dart';

class MedicalSurveyAnswerViewModel extends BaseViewModel {
  final MedicalSurveyRepository _surveyRepository =
      locator.get<MedicalSurveyRepository>();

  Future<DataResult> getSurveyAnswers({required String treatmentId}) {
    return handleTaskWithResultReturn(
      onRequest: () => _surveyRepository.getMedicalSurveyAnswers(
        treatmentId: treatmentId,
      ),
      showLoading: false,
      showErrorDialog: false,
    );
  }
}
