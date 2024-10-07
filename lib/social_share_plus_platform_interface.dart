import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'social_share_plus_method_channel.dart';

abstract class SocialSharePlusPlatform extends PlatformInterface {
  /// Constructs a SocialSharePlusPlatform.
  SocialSharePlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static SocialSharePlusPlatform _instance = MethodChannelSocialSharePlus();

  /// The default instance of [SocialSharePlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelSocialSharePlus].
  static SocialSharePlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SocialSharePlusPlatform] when
  /// they register themselves.
  static set instance(SocialSharePlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> shareInstagramStory({
    required String appId,
    required String imagePath,
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? backgroundResourcePath,
    String? attributionURL,
  }) {
    throw UnimplementedError('shareInstagramStory() has not been implemented.');
  }

  Future<String?> shareFacebookStory({
    required String appId,
    String? imagePath,
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? backgroundResourcePath,
    String? attributionURL,
  }) {
    throw UnimplementedError('shareFacebookStory() has not been implemented.');
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
    throw UnimplementedError('shareMetaStory() has not been implemented.');
  }

  Future<String?> shareTwitter(
      String captionText, {
        List<String>? hashtags,
        String? url,
        String? trailingText,
      }) {
    throw UnimplementedError('shareTwitter() has not been implemented.');
  }

  Future<String?> shareSms(String message, {String? url, String? trailingText}) {
    throw UnimplementedError('shareSms() has not been implemented.');
  }

  Future<String?> copyToClipboard({
    String? text,
    String? image,
  }) {
    throw UnimplementedError('copyToClipboard() has not been implemented.');
  }

  Future<bool?> shareOptions(String contentText, {String? imagePath}) {
    throw UnimplementedError('shareOptions() has not been implemented.');
  }

  Future<String?> shareTelegram(String content) {
    throw UnimplementedError('shareTelegram() has not been implemented.');
  }

  Future<String?> shareWhatsapp(String content) {
    throw UnimplementedError('shareWhatsapp() has not been implemented.');
  }

  Future<Map?> checkInstalledAppsForShare() {
    throw UnimplementedError(
        'checkInstalledAppsForShare() has not been implemented.');
  }

  Future<bool?> reSaveImage(String? imagePath, String filename) {
    throw UnimplementedError('reSaveImage() has not been implemented.');
  }
}