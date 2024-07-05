import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/screens/appointment/appointment_screen.dart';
import 'package:make_appointment_app/presentation/screens/appointment/appointment_view_model.dart';
import 'package:make_appointment_app/presentation/screens/appointment/confirm_appointment_screen.dart';
import 'package:make_appointment_app/presentation/screens/update_appointment/update_appointment_screen.dart';
import 'package:make_appointment_app/presentation/screens/update_appointment/update_appointment_view_model.dart';
import 'package:make_appointment_app/presentation/screens/update_appointment/confirm_update_appointment_screen.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/change_password_screen.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/change_password_viewmodel.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/complete_change_password_screen.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:make_appointment_app/presentation/screens/forgot_password/forgot_password_viewmodel.dart';
import 'package:make_appointment_app/presentation/screens/home/home_screen.dart';
import 'package:make_appointment_app/presentation/screens/home/home_view_model.dart';
import 'package:make_appointment_app/presentation/screens/login/login_screen.dart';
import 'package:make_appointment_app/presentation/screens/login/login_view_model.dart';
import 'package:make_appointment_app/presentation/screens/medical_survey_question/medical_survey_question_screen.dart';
import 'package:make_appointment_app/presentation/screens/medical_survey_question/medical_survey_question_view_model.dart';
import 'package:make_appointment_app/presentation/screens/post/post_screen.dart';
import 'package:make_appointment_app/presentation/screens/post/post_view_model.dart';
import 'package:make_appointment_app/presentation/screens/post_detail/post_detail_screen.dart';
import 'package:make_appointment_app/presentation/screens/post_detail/post_detail_view_model.dart';
import 'package:make_appointment_app/presentation/screens/profile/base_profile/profile_screen.dart';
import 'package:make_appointment_app/presentation/screens/profile/base_profile/profile_view_model.dart';
import 'package:make_appointment_app/presentation/screens/register/complete_register_screen.dart';
import 'package:make_appointment_app/presentation/screens/register/register_screen.dart';
import 'package:make_appointment_app/presentation/screens/register/register_viewmodel.dart';
import 'package:make_appointment_app/presentation/screens/register/verify_email_register_screen.dart';
import 'package:make_appointment_app/presentation/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:make_appointment_app/presentation/screens/profile/edit_profile/edit_profile_view_model.dart';
import 'package:make_appointment_app/presentation/screens/register/verify_email_viewmodel.dart';
import 'package:make_appointment_app/presentation/screens/service_instructions/service_instructions_screen.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_details/treatment_details_screen.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_list/treatment_list_screen.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_list/treatment_list_view_model.dart';
import 'package:provider/provider.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String post = '/post';
  static const String postDetail = '/postDetail';
  static const String serviceInstructions = '/serviceInstructions';
  static const String treatmentList = '/treatmentList';
  static const String treatmentDetails = '/treatmentDetails';
  static const String appointment = '/appointment';
  static const String confirmAppointment = '/confirmAppointment';
  static const String forgotPassword = '/forgotPassword';
  static const String changePassword = '/changePassword';
  static const String changeEmail = '/changeEmail';
  static const String completeResetPassword = '/completeResetPassword';
  static const String register = '/register';
  static const String verifyEmailRegister = '/verifyEmailRegister';
  static const String profile = '/profile';
  static const String completeRegister = '/completeRegister';
  static const String medicalSurveyQuestion = '/medicalSurveyQuestion';
  static const String editProfile = '/editProfile';
  static const String updateAppointment = '/updateAppointment';
  static const String confirmUpdateAppointment = '/confirmUpdateAppointment';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    final arg = (routeSettings.arguments as dynamic) ?? {};
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => HomeViewModel(),
            child: const HomeScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => LoginViewModel(),
            child: const LoginScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.post:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => PostViewModel(),
            child: const PostScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.postDetail:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => PostDetailViewModel(),
            child: PostDetailScreen(postId: arg),
          ),
          settings: routeSettings,
        );
      case Routes.serviceInstructions:
        return MaterialPageRoute(
          builder: (context) => const ServiceInstructionsScreen(),
          settings: routeSettings,
        );
      case Routes.treatmentList:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => TreatmentListViewModel(),
            child: const TreatmentListScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.treatmentDetails:
        return MaterialPageRoute(
          builder: (context) => TreatmentDetailsScreen(appointment: arg),
          settings: routeSettings,
        );

      case Routes.appointment:
        final medicalTreatment = arg['medicalTreatment'];
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => AppointmentViewModel(),
            child: AppointmentScreen(medicalTreatment: medicalTreatment),
          ),
          settings: routeSettings,
        );
      case Routes.confirmAppointment:
        final viewModel = arg['appointmentViewModel'] as AppointmentViewModel;
        final isFirstVisit = arg['isFirstVisit'];
        final time = arg['time'];
        final timeId = arg['timeId'];
        final date = arg['date'];
        final medicalTreatment = arg['medicalTreatment'];
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: viewModel,
            child: ConfirmAppointmentScreen(
              isFirstVisit: isFirstVisit,
              time: time,
              timeId: timeId,
              medicalTreatment: medicalTreatment,
              date: date,
            ),
          ),
          settings: routeSettings,
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            lazy: false,
            create: (context) => ProfileViewModel(),
            child: const ProfileScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ForgotPasswordViewModel(),
            child: const ForgotPasswordScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.changePassword:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ChangePasswordViewModel(),
            child: const ChangePasswordScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.completeResetPassword:
        return MaterialPageRoute(
          builder: (context) => const CompleteChangePasswordScreen(),
          settings: routeSettings,
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => RegisterViewModel(),
            child: const RegisterScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.verifyEmailRegister:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => VerifyEmailViewModel(),
            child: const VerifyEmailRegisterScreen(),
          ),
          settings: routeSettings,
        );
      case Routes.completeRegister:
        return MaterialPageRoute(
          builder: (context) => const CompleteRegisterScreen(),
          settings: routeSettings,
        );
      case Routes.medicalSurveyQuestion:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => MedicalSurveyQuestionViewModel(),
            child: MedicalSurveyQuestionScreen(appointment: arg),
          ),
          settings: routeSettings,
        );
      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            lazy: false,
            create: (context) => EditProfileViewModel(),
            child: EditProfileScreen(user: arg['user']),
          ),
          settings: routeSettings,
        );
      case Routes.updateAppointment:
        final appointment = arg['appointment'];
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => UpdateAppointmentViewModel(),
            child: UpdateAppointmentScreen(appointment: appointment),
          ),
          settings: routeSettings,
        );
      case Routes.confirmUpdateAppointment:
        final viewModel =
            arg['updateAppointmentViewModel'] as UpdateAppointmentViewModel;
        final isFirstVisit = arg['isFirstVisit'];
        final appointmentId = arg['appointmentId'];
        final time = arg['time'];
        final timeId = arg['timeId'];
        final date = arg['date'];
        final medicalTreatment = arg['medicalTreatment'];
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: viewModel,
            child: ConfirmUpdateAppointmentScreen(
              appointmentId: appointmentId,
              isFirstVisit: isFirstVisit,
              time: time,
              timeId: timeId,
              medicalTreatment: medicalTreatment,
              date: date,
            ),
          ),
          settings: routeSettings,
        );
      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}
