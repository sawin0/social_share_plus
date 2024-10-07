import 'package:flutter_test/flutter_test.dart';
import 'package:social_share_plus/social_share_plus.dart';
import 'package:social_share_plus/social_share_plus_platform_interface.dart';
import 'package:social_share_plus/social_share_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSocialSharePlusPlatform
    with MockPlatformInterfaceMixin
    implements SocialSharePlusPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SocialSharePlusPlatform initialPlatform = SocialSharePlusPlatform.instance;

  test('$MethodChannelSocialSharePlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSocialSharePlus>());
  });

  test('getPlatformVersion', () async {
    SocialSharePlus socialSharePlusPlugin = SocialSharePlus();
    MockSocialSharePlusPlatform fakePlatform = MockSocialSharePlusPlatform();
    SocialSharePlusPlatform.instance = fakePlatform;

    expect(await socialSharePlusPlugin.getPlatformVersion(), '42');
  });
}
