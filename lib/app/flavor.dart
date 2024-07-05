import 'package:flutter/services.dart';
import 'package:make_appointment_app/app/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Flavor {
  Flavor._();

  static const platform = MethodChannel('flutter.method.channel');

  static Future<void> settings() async {
    final flavor = await platform.invokeMethod<String>('getFlavor') ?? 'dev';
    await dotenv.load(
      fileName: Environment.fileName(EnvironmentType.values.byName(flavor)),
    );
  }
}
