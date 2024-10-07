import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share_plus/social_share_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String facebookId = "xxxxxxxx";

  var imageBackground = "image-background.jpg";
  var videoBackground = "video-background.mp4";
  String imageBackgroundPath = "";
  String videoBackgroundPath = "";
  final SocialSharePlus socialSharePlus = SocialSharePlus();

  @override
  void initState() {
    super.initState();
    copyBundleAssets();
  }

  Future<void> copyBundleAssets() async {
    imageBackgroundPath = await copyImage(imageBackground);
    videoBackgroundPath = await copyImage(videoBackground);
  }

  Future<String> copyImage(String filename) async {
    final tempDir = await getTemporaryDirectory();
    ByteData bytes = await rootBundle.load("assets/$filename");
    final assetPath = '${tempDir.path}/$filename';
    File file = await File(assetPath).create();
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file.path;
  }

  Future<String?> pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    var path = file?.path;
    if (path == null) {
      return null;
    }
    return file?.path;
  }

  Future<String?> screenshot() async {
    var data = await screenshotController.capture();
    if (data == null) {
      return null;
    }
    final tempDir = await getTemporaryDirectory();
    final assetPath = '${tempDir.path}/temp.png';
    File file = await File(assetPath).create();
    await file.writeAsBytes(data);
    return file.path;
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Social Share'),
        ),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Instagram",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        child: const Icon(Icons.gradient),
                        onPressed: () async {
                          var path = await pickImage();
                          if (path == null) {
                            return;
                          }
                          socialSharePlus
                              .shareInstagramStory(
                            appId: facebookId,
                            imagePath: path,
                            backgroundTopColor: "#ffffff",
                            backgroundBottomColor: "#000000",
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        child: const Icon(Icons.image),
                        onPressed: () async {
                          var path = await pickImage();
                          if (path == null) {
                            return;
                          }
                          socialSharePlus
                              .shareInstagramStory(
                            appId: facebookId,
                            imagePath: path,
                            backgroundResourcePath: imageBackgroundPath,
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        child: const Icon(Icons.videocam),
                        onPressed: () async {
                          var path = await screenshot();
                          if (path == null) {
                            return;
                          }
                          socialSharePlus
                              .shareInstagramStory(
                            appId: facebookId,
                            imagePath: path,
                            backgroundResourcePath: videoBackgroundPath,
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Facebook",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        child: const Icon(Icons.gradient),
                        onPressed: () async {
                          var path = await pickImage();
                          if (path == null) {
                            return;
                          }
                          socialSharePlus
                              .shareFacebookStory(
                            appId: facebookId,
                            imagePath: path,
                            backgroundTopColor: "#ffffff",
                            backgroundBottomColor: "#000000",
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        child: const Icon(Icons.image),
                        onPressed: () async {
                          var path = await pickImage();
                          if (path == null) {
                            return;
                          }
                          socialSharePlus
                              .shareFacebookStory(
                            appId: facebookId,
                            imagePath: path,
                            backgroundResourcePath: imageBackgroundPath,
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        child: const Icon(Icons.videocam),
                        onPressed: () async {
                          var path = await screenshot();
                          if (path == null) {
                            return;
                          }
                          await socialSharePlus
                              .shareFacebookStory(
                            appId: facebookId,
                            imagePath: path,
                            backgroundResourcePath: videoBackgroundPath,
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Twitter",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        child: const Icon(Icons.text_fields),
                        onPressed: () async {
                          socialSharePlus
                              .shareTwitter(
                            "This is Social Share twitter example with link.  ",
                            hashtags: [
                              "SocialSharePlusPlugin",
                              "world",
                              "foo",
                              "bar"
                            ],
                            url: "https://google.com/hello",
                            trailingText: "cool!!",
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Clipboard",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        child: const Icon(Icons.image),
                        onPressed: () async {
                          socialSharePlus
                              .copyToClipboard(
                            image: await screenshot(),
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        child: const Icon(Icons.text_fields),
                        onPressed: () async {
                          socialSharePlus
                              .copyToClipboard(
                            text: "This is Social Share plugin",
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "SMS",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        child: const Icon(Icons.text_fields),
                        onPressed: () async {
                          socialSharePlus
                              .shareSms(
                            "This is Social Share Sms example",
                            url: "https://google.com/",
                            trailingText: "\nhello",
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Share Options",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        child: const Icon(Icons.text_fields),
                        onPressed: () async {
                          socialSharePlus
                              .shareOptions("Hello world")
                              .then((data) {
                            debugPrint(data.toString());
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Whatsapp",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        onPressed: () async {
                          socialSharePlus
                              .shareWhatsapp(
                            "Hello World \n https://google.com",
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                        child: const Icon(Icons.text_fields),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Telegram",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        onPressed: () async {
                          socialSharePlus
                              .shareTelegram(
                            "Hello World \n https://google.com",
                          )
                              .then((data) {
                            debugPrint(data);
                          });
                        },
                        child: const Icon(Icons.text_fields),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Get all Apps",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        child: const Icon(Icons.text_fields),
                        onPressed: () async {
                          socialSharePlus
                              .checkInstalledAppsForShare()
                              .then((data) {
                            debugPrint(data.toString());
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}