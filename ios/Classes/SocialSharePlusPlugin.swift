import Flutter
import UIKit

public class SocialSharePlusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "social_share_plus", binaryMessenger: registrar.messenger())
    let instance = SocialSharePlusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
          switch call.method {
          case "shareInstagramStory", "shareFacebookStory":
              handleShareStory(call: call, result: result)
          case "copyToClipboard":
              handleCopyToClipboard(call: call, result: result)
          case "shareTwitter":
              handleShareTwitter(call: call, result: result)
          case "shareSms":
              handleShareSms(call: call, result: result)
          case "shareSlack":
              result(true)
          case "shareWhatsapp":
              handleShareWhatsApp(call: call, result: result)
          case "shareTelegram":
              handleShareTelegram(call: call, result: result)
          case "shareOptions":
              handleShareOptions(call: call, result: result)
          case "checkInstalledApps":
              handleCheckInstalledApps(result: result)
          default:
              result(FlutterMethodNotImplemented)
          }
      }

      private func handleShareStory(call: FlutterMethodCall, result: @escaping FlutterResult) {
          let isInstagram = call.method == "shareInstagramStory"
          let destination = isInstagram ? "com.instagram.sharedSticker" : "com.facebook.sharedSticker"
          let stories = isInstagram ? "instagram-stories" : "facebook-stories"

          guard let args = call.arguments as? [String: Any] else { return }

          let stickerImage = args["stickerImage"] as? String ?? ""
          let backgroundTopColor = args["backgroundTopColor"] as? String ?? ""
          let backgroundBottomColor = args["backgroundBottomColor"] as? String ?? ""
          let attributionURL = args["attributionURL"] as? String ?? ""
          let backgroundImage = args["backgroundImage"] as? String ?? ""
          let backgroundVideo = args["backgroundVideo"] as? String ?? ""

          let fileManager = FileManager.default

          var appId = args["appId"] as? String ?? ""
          if backgroundTopColor.isEmpty {
              if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
                 let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                  appId = dict["FacebookAppID"] as? String ?? ""
              }
          }

          var imgShare: Data?
          if fileManager.fileExists(atPath: stickerImage) {
              imgShare = try? Data(contentsOf: URL(fileURLWithPath: stickerImage))
          }

          var pasteboardItems: [String: Any] = ["\(destination).stickerImage": imgShare as Any]

          if !backgroundTopColor.isEmpty {
              pasteboardItems["\(destination).backgroundTopColor"] = backgroundTopColor
          }
          if !backgroundBottomColor.isEmpty {
              pasteboardItems["\(destination).backgroundBottomColor"] = backgroundBottomColor
          }
          if !attributionURL.isEmpty {
              pasteboardItems["\(destination).contentURL"] = attributionURL
          }
          if !appId.isEmpty && call.method == "shareFacebookStory" {
              pasteboardItems["\(destination).appID"] = appId
          }

          if fileManager.fileExists(atPath: backgroundImage) {
              let imgBackgroundShare = try? Data(contentsOf: URL(fileURLWithPath: backgroundImage))
              pasteboardItems["\(destination).backgroundImage"] = imgBackgroundShare
          }

          if fileManager.fileExists(atPath: backgroundVideo) {
              let videoBackgroundShare = try? Data(contentsOf: URL(fileURLWithPath: backgroundVideo))
              pasteboardItems["\(destination).backgroundVideo"] = videoBackgroundShare
          }

          let urlScheme = URL(string: "\(stories)://share?source_application=\(appId)")!

          if UIApplication.shared.canOpenURL(urlScheme) {
              let pasteboardOptions: [UIPasteboard.OptionsKey: Any] = [.expirationDate: Date().addingTimeInterval(60 * 5)]
              UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)

              if #available(iOS 10.0, *) {
                  UIApplication.shared.open(urlScheme, options: [:]) { _ in
                      result("success")
                  }
              } else {
                  result("error")
              }
          } else {
              result("error")
          }
      }

      private func handleCopyToClipboard(call: FlutterMethodCall, result: @escaping FlutterResult) {
          guard let args = call.arguments as? [String: Any] else { return }

          if let content = args["content"] as? String {
              UIPasteboard.general.string = content
          }

          if let imagePath = args["image"] as? String, FileManager.default.fileExists(atPath: imagePath) {
              if let imageData = UIImage(contentsOfFile: imagePath) {
                  UIPasteboard.general.image = imageData
              }
          }

          result("success")
      }

      private func handleShareTwitter(call: FlutterMethodCall, result: @escaping FlutterResult) {
          guard let args = call.arguments as? [String: Any],
                let captionText = args["captionText"] as? String else { return }

          let urlSchemeTwitter = "twitter://post?message=\(captionText)"
          let urlSchemeSend = URL(string: urlSchemeTwitter.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

          if #available(iOS 10.0, *) {
              UIApplication.shared.open(urlSchemeSend, options: [:]) { _ in
                  result("success")
              }
          } else {
              result("error")
          }
      }

      private func handleShareSms(call: FlutterMethodCall, result: @escaping FlutterResult) {
          guard let args = call.arguments as? [String: Any] else { return }

          let msg = args["message"] as? String ?? ""
          let urlstring = args["urlLink"] as? String ?? ""
          let trailingText = args["trailingText"] as? String ?? ""

          let urlScheme = URL(string: "sms://")!

          let urlTextEscaped = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
          let url = URL(string: urlTextEscaped)!

          if url.absoluteString.isEmpty {
              let urlSchemeSms = "sms:?&body=\(msg)"
              let urlScheme = URL(string: urlSchemeSms)!

              if UIApplication.shared.canOpenURL(urlScheme) {
                  if #available(iOS 10.0, *) {
                      UIApplication.shared.open(urlScheme, options: [:]) { _ in
                          result("success")
                      }
                  } else {
                      result("error")
                  }
              } else {
                  result("error")
              }
          } else {
              let urlSchemeSms = "sms:?&body=\(msg)"
              let urlWithLink = urlSchemeSms + url.absoluteString
              let urlSchemeMsg = URL(string: urlWithLink)!

              if UIApplication.shared.canOpenURL(urlScheme) {
                  if #available(iOS 10.0, *) {
                      UIApplication.shared.open(urlSchemeMsg, options: [:]) { _ in
                          result("success")
                      }
                  } else {
                      result("error")
                  }
              } else {
                  result("error")
              }
          }
      }

      private func handleShareWhatsApp(call: FlutterMethodCall, result: @escaping FlutterResult) {
          guard let args = call.arguments as? [String: Any],
                let content = args["content"] as? String else { return }

          let urlWhats = "whatsapp://send?text=\(content)"
          let whatsappURL = URL(string: urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

          if UIApplication.shared.canOpenURL(whatsappURL) {
              UIApplication.shared.open(whatsappURL) { _ in
                  result("success")
              }
          } else {
              result("error")
          }
      }

      private func handleShareTelegram(call: FlutterMethodCall, result: @escaping FlutterResult) {
          guard let args = call.arguments as? [String: Any],
                let content = args["content"] as? String else { return }

          let urlScheme = "tg://msg?text=\(content)"
          let telegramURL = URL(string: urlScheme.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

          if UIApplication.shared.canOpenURL(telegramURL) {
              UIApplication.shared.open(telegramURL) { _ in
                  result("success")
              }
          } else {
              result("error")
          }
      }

      private func handleShareOptions(call: FlutterMethodCall, result: @escaping FlutterResult) {
          guard let args = call.arguments as? [String: Any] else { return }

          let content = args["content"] as? String ?? ""
          let image = args["image"] as? String ?? ""

          var objectsToShare: [Any] = [content]

          if !image.isEmpty, FileManager.default.fileExists(atPath: image), let imgShare = UIImage(contentsOfFile: image) {
              objectsToShare.append(imgShare)
          }

          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

          if let topController = UIApplication.shared.keyWindow?.rootViewController {
              topController.present(activityVC, animated: true, completion: nil)
          }

          result("success")
      }

      private func handleCheckInstalledApps(result: @escaping FlutterResult) {
          var apps: [String] = []

          if UIApplication.shared.canOpenURL(URL(string: "whatsapp://")!) {
              apps.append("WhatsApp")
          }
          if UIApplication.shared.canOpenURL(URL(string: "tg://")!) {
              apps.append("Telegram")
          }
          if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
              apps.append("Twitter")
          }
          if UIApplication.shared.canOpenURL(URL(string: "sms://")!) {
              apps.append("SMS")
          }

          result(apps)
      }
}
