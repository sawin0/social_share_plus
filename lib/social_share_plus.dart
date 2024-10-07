
import 'social_share_plus_platform_interface.dart';

class SocialSharePlus {
  Future<String?> shareInstagramStory({
    required String appId,
    required String imagePath,
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? backgroundResourcePath,
    String? attributionURL,
  }) {
    return SocialSharePlusPlatform.instance.shareInstagramStory(
      appId: appId,
      imagePath: imagePath,
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      attributionURL: attributionURL,
      backgroundResourcePath: backgroundResourcePath,
    );
  }

  Future<String?> shareFacebookStory({
    required String appId,
    String? imagePath,
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? backgroundResourcePath,
    String? attributionURL,
  }) {
    return SocialSharePlusPlatform.instance.shareFacebookStory(
      appId: appId,
      imagePath: imagePath,
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      attributionURL: attributionURL,
      backgroundResourcePath: backgroundResourcePath,
    );
  }

  Future<String?> shareMetaStory({
    required String appId,
    required String platform,
    String? imagePath,
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? backgroundResourcePath,
    String? attributionURL,
  }) {
    return SocialSharePlusPlatform.instance.shareMetaStory(
      appId: appId,
      platform: platform,
      imagePath: imagePath,
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      attributionURL: attributionURL,
      backgroundResourcePath: backgroundResourcePath,
    );
  }

  Future<String?> shareTwitter(
      String captionText, {
        List<String>? hashtags,
        String? url,
        String? trailingText,
      }) {
    return SocialSharePlusPlatform.instance.shareTwitter(
      captionText,
      hashtags: hashtags,
      url: url,
      trailingText: trailingText,
    );
  }

  Future<String?> shareSms(String message,
      {String? url, String? trailingText}) {
    return SocialSharePlusPlatform.instance.shareSms(
      message,
      url: url,
    );
  }

  Future<String?> copyToClipboard({
    String? text,
    String? image,
  }) {
    return SocialSharePlusPlatform.instance.copyToClipboard(
      text: text,
      image: image,
    );
  }

  Future<bool?> shareOptions(String contentText, {String? imagePath}) {
    return SocialSharePlusPlatform.instance.shareOptions(
      contentText,
      imagePath: imagePath,
    );
  }

  Future<String?> shareTelegram(String content) {
    return SocialSharePlusPlatform.instance.shareTelegram(content);
  }

  Future<String?> shareWhatsapp(String content) {
    return SocialSharePlusPlatform.instance.shareWhatsapp(content);
  }

  Future<Map?> checkInstalledAppsForShare() {
    return SocialSharePlusPlatform.instance.checkInstalledAppsForShare();
  }

  Future<bool?> reSaveImage(String? image, String filename) {
    return SocialSharePlusPlatform.instance.reSaveImage(image, filename);
  }
}