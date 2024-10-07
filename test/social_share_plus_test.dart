import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:social_share_plus/social_share_plus.dart';
import 'package:social_share_plus/social_share_plus_method_channel.dart';
import 'package:social_share_plus/social_share_plus_platform_interface.dart';

class MockSocialSharePlusPlatform
    with MockPlatformInterfaceMixin
    implements SocialSharePlusPlatform {
  @override
  Future<Map?> checkInstalledAppsForShare() {
    // TODO: implement checkInstalledAppsForShare
    throw UnimplementedError();
  }

  @override
  Future<String?> copyToClipboard({String? text, String? image}) {
    // TODO: implement copyToClipboard
    throw UnimplementedError();
  }

  @override
  Future<bool?> reSaveImage(String? imagePath, String filename) {
    // TODO: implement reSaveImage
    throw UnimplementedError();
  }

  @override
  Future<String?> shareFacebookStory(
      {required String appId,
      String? imagePath,
      String? backgroundTopColor,
      String? backgroundBottomColor,
      String? backgroundResourcePath,
      String? attributionURL}) {
    // TODO: implement shareFacebookStory
    throw UnimplementedError();
  }

  @override
  Future<String?> shareInstagramStory(
      {required String appId,
      required String imagePath,
      String? backgroundTopColor,
      String? backgroundBottomColor,
      String? backgroundResourcePath,
      String? attributionURL}) {
    // TODO: implement shareInstagramStory
    throw UnimplementedError();
  }

  @override
  Future<String?> shareMetaStory(
      {required String appId,
      required String platform,
      String? imagePath,
      String? backgroundTopColor,
      String? backgroundBottomColor,
      String? backgroundResourcePath,
      String? attributionURL}) {
    // TODO: implement shareMetaStory
    throw UnimplementedError();
  }

  @override
  Future<bool?> shareOptions(String contentText, {String? imagePath}) {
    // TODO: implement shareOptions
    throw UnimplementedError();
  }

  @override
  Future<String?> shareSms(String message,
      {String? url, String? trailingText}) {
    // TODO: implement shareSms
    throw UnimplementedError();
  }

  @override
  Future<String?> shareTelegram(String content) {
    // TODO: implement shareTelegram
    throw UnimplementedError();
  }

  @override
  Future<String?> shareTwitter(String captionText,
      {List<String>? hashtags, String? url, String? trailingText}) {
    // TODO: implement shareTwitter
    throw UnimplementedError();
  }

  @override
  Future<String?> shareWhatsapp(String content) {
    // TODO: implement shareWhatsapp
    throw UnimplementedError();
  }
}

void main() {
  final SocialSharePlusPlatform initialPlatform =
      SocialSharePlusPlatform.instance;

  test('$MethodChannelSocialSharePlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSocialSharePlus>());
  });

  test('getPlatformVersion', () async {
    SocialSharePlus socialSharePlusPlugin = SocialSharePlus();
    MockSocialSharePlusPlatform fakePlatform = MockSocialSharePlusPlatform();
    SocialSharePlusPlatform.instance = fakePlatform;
  });
}
