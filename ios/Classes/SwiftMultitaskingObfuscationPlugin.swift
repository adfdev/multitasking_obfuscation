import Flutter
import UIKit

public class SwiftMultitaskingObfuscationPlugin: NSObject, FlutterPlugin {
    let secureOverlayViewTag : Int = 999995464783
    var backgroundColor : UIColor = UIColor.white
    var image : UIImage? = UIImage()
    var imageWidth : Int = 0
    var imageHeigth : Int = 0
    var contentViewMode : UIView.ContentMode = .center
    
    let window = UIApplication.shared.windows.first
    
    internal let registrar: FlutterPluginRegistrar
    
    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
      super.init()
      registrar.addApplicationDelegate(self)
    }
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "multitasking_obfuscation", binaryMessenger: registrar.messenger())
    let instance = SwiftMultitaskingObfuscationPlugin(registrar: registrar)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        self.prepareForEnteringIntoBackgroundMode()

    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        self.prepareForEnteringIntoActiveMode()
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "init") {
                if let args = call.arguments as? Dictionary<String, Any>,
                    let hexColor = args["hexColor"] as? UInt,
                    let bytesImage = args["bytesImage"] as? FlutterStandardTypedData,
                    let _imageWidth = args["imageWidth"] as? Int,
                    let _imageHeight = args["imageHeight"] as? Int,
                    let _contentViewMode = args["contentViewMode"] as? String
                    {
                    self.backgroundColor = UIColor(rgb: hexColor)
                    self.image = UIImage(data: bytesImage.data)
                    self.imageWidth = _imageWidth
                    self.imageHeigth = _imageHeight
                    self.contentViewMode = self.getContentViewMode(type: _contentViewMode)
                    }
            } else {
                result(FlutterMethodNotImplemented)
                return
            }
  }
    
    private func prepareForEnteringIntoBackgroundMode() {
        let imageView = UIImageView()
        imageView.frame = window!.frame
        imageView.tag = secureOverlayViewTag
        imageView.contentMode = contentViewMode
        imageView.backgroundColor = backgroundColor
        window?.addSubview(imageView)
        imageView.image = image?.resize(withSize: CGSize(width: imageWidth, height: imageHeigth), contentMode: .contentAspectFill)
    }

    private func prepareForEnteringIntoActiveMode() {
        self.window?.viewWithTag(secureOverlayViewTag)?.removeFromSuperview()
    }

    private func getContentViewMode(type: String) -> UIView.ContentMode {
        if type == "center" {return UIView.ContentMode.center}
        else if type == "top" {return UIView.ContentMode.top}
        else if type == "bottom" {return UIView.ContentMode.bottom}
        else { return UIView.ContentMode.center}
    }
}

extension UIColor {

    convenience init(rgb: UInt) {
        self.init(rgb: rgb, alpha: 1.0)
    }

    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}

extension UIImage {
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }
    
    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height
        
        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }
    
    private func resize(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
