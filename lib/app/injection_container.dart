import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/data/local/local_storage_service.dart';
import 'package:make_appointment_app/data/local/shared_preferences_service.dart';
import 'package:make_appointment_app/data/remote/appointment_api.dart';
import 'package:make_appointment_app/data/remote/auth_api.dart';
import 'package:make_appointment_app/data/remote/medial_treatment_api.dart';
import 'package:make_appointment_app/data/remote/medical_survey_api.dart';
import 'package:make_appointment_app/data/remote/post_api.dart';
import 'package:make_appointment_app/data/remote/profile_api.dart';
import 'package:make_appointment_app/repository/appointment_repository.dart';
import 'package:make_appointment_app/repository/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:make_appointment_app/repository/medical_survey_repository.dart';
import 'package:make_appointment_app/repository/medical_treatment_repository.dart';
import 'package:make_appointment_app/repository/post_repository.dart';
import 'package:make_appointment_app/repository/profile_repository.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // services
  locator.registerSingleton<LocalStorageService>(LocalStorageService());
  locator.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(
      sharedPreferences: locator.get<LocalStorageService>().sharedPreferences,
    ),
  );

  // remote data source
  locator.registerLazySingleton<AuthApi>(
    () => AuthApi(),
  );
  locator.registerLazySingleton<PostApi>(
    () => PostApi(),
  );

  locator.registerLazySingleton<AppointmentApi>(
    () => AppointmentApi(),
  );
  locator.registerLazySingleton<MedicalTreatmentApi>(
    () => MedicalTreatmentApi(),
  );

  locator.registerLazySingleton<ProfileApi>(
    () => ProfileApi(),
  );
  locator.registerLazySingleton<MedicalSurveyApi>(
    () => MedicalSurveyApi(),
  );

  // repository

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      appData: locator.get<AppData>(),
      authApi: locator.get<AuthApi>(),
      sharedPreferencesService: locator.get<SharedPreferencesService>(),
    ),
  );
  locator.registerLazySingleton<PostRepository>(
    () => PostRepository(postApi: locator.get<PostApi>()),
  );
  locator.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepository(appointmentApi: locator.get<AppointmentApi>()),
  );
  locator.registerLazySingleton<MedicalTreatmentRepository>(
    () => MedicalTreatmentRepository(
      medicalTreatmentApi: locator.get<MedicalTreatmentApi>(),
      appData: locator.get<AppData>(),
    ),
  );

  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      profileApi: locator.get<ProfileApi>(),
    ),
  );
  locator.registerLazySingleton<MedicalSurveyRepository>(
    () => MedicalSurveyRepository(
      surveyApi: locator.get<MedicalSurveyApi>(),
    ),
  );

  // Appdata
  locator.registerLazySingleton<AppData>(
    () => AppData(),
  );
}
