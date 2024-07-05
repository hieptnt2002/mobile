import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let flutterChannel = FlutterMethodChannel(
      name: "flutter.method.channel",
      binaryMessenger: controller.binaryMessenger
    )
    flutterChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard let self  = self else { return }
      if call.method == "getFlavor"{
        result(self.getFlavor())
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func getFlavor() -> String {
    return Bundle.main.infoDictionary?["App - Flavor"] as? String ?? "dev";
  }
}
