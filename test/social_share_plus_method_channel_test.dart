import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_share_plus/social_share_plus_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSocialSharePlus platform = MethodChannelSocialSharePlus();
  const MethodChannel channel = MethodChannel('social_share_plus');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
