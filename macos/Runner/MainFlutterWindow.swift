import Cocoa
import FlutterMacOS
import CoreWLAN

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame

    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()


    let channel = FlutterMethodChannel(name: "wifi-information", binaryMessenger: flutterViewController.engine.binaryMessenger)
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if (call.method == "wifiName") {
            let cwinterface = CWWiFiClient.shared().interface()
            result(cwinterface?.ssid())
        } else {
            result(FlutterMethodNotImplemented)
        }
    })
  }
}
