import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'social_share_plus_platform_interface.dart';

/// An implementation of [SocialSharePlusPlatform] that uses method channels.
class MethodChannelSocialSharePlus extends SocialSharePlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('social_share_plus');

  @override
  Future<String?> shareInstagramStory({
    required String appId,
    required String imagePath,
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? backgroundResourcePath,
    String? attributionURL,
  }) async {
    return shareMetaStory(
      appId: appId,
      platform: "shareInstagramStory",
      imagePath: imagePath,
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      attributionURL: attributionURL,
      backgroundResourcePath: backgroundResourcePath,
    );
  }

  @override
  Future<String?> shareFacebookStory({
    required String appId,
    String? imagePath,
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? backgroundResourcePath,
    String? attributionURL,
  }) async {
    return shareMetaStory(
      appId: appId,
      platform: "shareFacebookStory",
      imagePath: imagePath,
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      attributionURL: attributionURL,
      backgroundResourcePath: backgroundResourcePath,
    );
  }

  @override
  Future<String?> shareMetaStory({
    required String appId,
    required String platform,
    String? imagePath,
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? attributionURL,
    String? backgroundResourcePath,
  }) async {
    if (Platform.isAndroid) {
      var stickerFilename = "stickerAsset.png";
      await reSaveImage(imagePath, stickerFilename);
      imagePath = stickerFilename;
      if (backgroundResourcePath != null) {
        var backgroundImageFilename = backgroundResourcePath.split("/").last;
        await reSaveImage(backgroundResourcePath, backgroundImageFilename);
        backgroundResourcePath = backgroundImageFilename;
      }
    }

    Map<String, dynamic> args = <String, dynamic>{
      "stickerImage": imagePath,
      "backgroundTopColor": backgroundTopColor,
      "backgroundBottomColor": backgroundBottomColor,
      "attributionURL": attributionURL,
      "appId": appId
    };

    if (backgroundResourcePath != null) {
      var extension = backgroundResourcePath.split(".").last;
      if (["png", "jpg", "jpeg"].contains(extension.toLowerCase())) {
        args["backgroundImage"] = backgroundResourcePath;
      } else {
        args["backgroundVideo"] = backgroundResourcePath;
      }
    }

    final String? response =
    await methodChannel.invokeMethod("shareInstagramStory", args);
    return response;
  }

  @override
  Future<String?> shareTwitter(
      String captionText, {
        List<String>? hashtags,
        String? url,
        String? trailingText,
      }) async {
    //Caption

    //Hashtags
    if (hashtags != null && hashtags.isNotEmpty) {
      final tags = hashtags.map((t) => '#$t ').join(' ');
      captionText = "$captionText\n$tags";
    }

    //Url
    String _url;
    if (url != null) {
      if (Platform.isAndroid) {
        _url = Uri.parse(url).toString().replaceAll('#', "%23");
      } else {
        _url = Uri.parse(url).toString();
      }
      captionText = "$captionText\n$_url";
    }

    if (trailingText != null) {
      captionText = "$captionText\n$trailingText";
    }

    Map<String, dynamic> args = <String, dynamic>{
      "captionText": "$captionText ",
    };
    final String? version =
    await methodChannel.invokeMethod('shareTwitter', args);
    return version;
  }

  @override
  Future<String?> shareSms(String message,
      {String? url, String? trailingText}) async {
    Map<String, dynamic>? args;
    if (Platform.isIOS) {
      if (url == null) {
        args = <String, dynamic>{
          "message": message,
        };
      } else {
        args = <String, dynamic>{
          "message": "$message ",
          "urlLink": Uri.parse(url).toString(),
          "trailingText": trailingText
        };
      }
    } else if (Platform.isAndroid) {
      args = <String, dynamic>{
        "message": message + (url ?? '') + (trailingText ?? ''),
      };
    }
    final String? version = await methodChannel.invokeMethod('shareSms', args);
    return version;
  }

  @override
  Future<String?> copyToClipboard({String? text, String? image}) async {
    final Map<String, dynamic> args = <String, dynamic>{
      "content": text,
      "image": image,
    };
    final String? response =
    await methodChannel.invokeMethod('copyToClipboard', args);
    return response;
  }

  @override
  Future<bool?> shareOptions(String contentText, {String? imagePath}) async {
    Map<String, dynamic> args;

    if (Platform.isAndroid) {
      if (imagePath != null) {
        var stickerFilename = "stickerAsset.png";
        await reSaveImage(imagePath, stickerFilename);
        imagePath = stickerFilename;
      }
    }
    args = <String, dynamic>{"image": imagePath, "content": contentText};
    final bool? version =
    await methodChannel.invokeMethod('shareOptions', args);
    return version;
  }

  @override
  Future<String?> shareWhatsapp(String content) async {
    final Map<String, dynamic> args = <String, dynamic>{"content": content};
    final String? version =
    await methodChannel.invokeMethod('shareWhatsapp', args);
    return version;
  }

  @override
  Future<Map?> checkInstalledAppsForShare() async {
    final Map? apps = await methodChannel.invokeMethod('checkInstalledApps');
    return apps;
  }

  @override
  Future<String?> shareTelegram(String content) async {
    final Map<String, dynamic> args = <String, dynamic>{"content": content};
    final String? version =
    await methodChannel.invokeMethod('shareTelegram', args);
    return version;
  }

  // static Future<String> shareSlack() async {
  //   final String version = await methodChannel.invokeMethod('shareSlack');
  //   return version;
  // }

  //Utils
  @override
  Future<bool> reSaveImage(String? imagePath, String filename) async {
    if (imagePath == null) {
      return false;
    }
    final tempDir = await getTemporaryDirectory();

    File file = File(imagePath);
    Uint8List bytes = file.readAsBytesSync();
    var stickerData = bytes.buffer.asUint8List();
    String stickerAssetName = filename;
    final Uint8List stickerAssetAsList = stickerData;
    final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
    file = await File(stickerAssetPath).create();
    file.writeAsBytesSync(stickerAssetAsList);
    return true;
  }
}