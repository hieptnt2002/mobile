import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:make_appointment_app/app/flavor.dart';
import 'package:make_appointment_app/app/injection_container.dart' as di;
import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/data/local/local_storage_service.dart';
import 'package:make_appointment_app/data/local/shared_preferences_service.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/home/home_screen.dart';
import 'package:make_appointment_app/presentation/screens/home/home_view_model.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flavor.settings();
  await di.init();
  await di.locator.get<LocalStorageService>().initialize();
  await di.locator.get<AppData>().initialize();
  final locale = di.locator.get<SharedPreferencesService>().getLocale();
  LocaleSettings.setLocaleRaw(locale);
  runApp(TranslationProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorKey: Utils.navigatorKey,
        onGenerateRoute: RouteGenerator.getRoute,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
