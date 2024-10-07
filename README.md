# Note: 
This is a fork of the original plugin [social_share](https://pub.dev/packages/social_share) with the following changes:
- Upgraded to latest version of flutter 3.22.0
- Creating object of SocialSharePlus class instead of a singleton instance

# social_share

Wide variety of sharing options you'll need to share directly to certain popular apps or just share with default native share.

## Introduction

Works on both platforms `Android` and `iOS`

It provides you with most of the popular sharing options
With this plugin you can share on instagram stories and facebook stories and also copy to clipboard

## Usage

### Android Configuration

#### Paste the following attribute in the `manifest` tag in the `android/app/src/main/AndroidManifest.xml`:

```
 		`xmlns:tools="http://schemas.android.com/tools"`
```

##### For example:

```
        <manifest xmlns:android="http://schemas.android.com/apk/res/android"
                xmlns:tools="http://schemas.android.com/tools"
                package="your package...">
```

#### Add this piece of code in the `manifest/application` in the `android/app/src/main/AndroidManifest.xml`:

```
 		<provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.com.shekarmudaliyar.social_share"
            android:exported="false"
            android:grantUriPermissions="true"
            tools:replace="android:authorities">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/filepaths" />
        </provider>
```

#### Create a xml file named `filepaths.xml` in the `app/src/main/res/xml` folder and paste this code in the file :

```
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <cache-path name="image" path="/"/>
</paths>
```

### iOS Configuration

#### Add this to your `Info.plist` to use share on instagram and facebook story

```
<key>LSApplicationQueriesSchemes</key>
	<array>
	<string>instagram-stories</string>
	<string>facebook-stories</string>
	<string>facebook</string>
	<string>instagram</string>
	<string>twitter</string>
	<string>whatsapp</string>
    <string>tg</string>
	</array>
```

### Add this if you are using share on facebook. For this you have to create an app on https://developers.facebook.com/ and get the App ID

```
<key>FacebookAppID</key>
<string>xxxxxxxxxxxxxxx</string>
```

#### shareInstagramStory

```
SocialSharePlus().shareInstagramStory(imageFile.path, "#ffffff",
                              "#000000", "https://deep-link-url");
```

#### shareInstagramStorywithBackground

```
 SocialSharePlus().shareInstagramStorywithBackground(image.path, "https://deep-link-url",
                              backgroundImagePath: backgroundimage.path);
```

#### shareFacebookStory

For iOS

```
SocialSharePlus().shareFacebookStory(image.path,"#ffffff","#000000",
                              "https://deep-link-url","facebook-app-id");
```

For Android
appID is mandatory if using shareFacebookStory or else it wont work

```
SocialSharePlus().shareFacebookStory(image.path,"#ffffff","#000000",
                              "https://deep-link-url","facebook-app-id",
							  appId: "xxxxxxxxxxxxx");
```

#### copyToClipboard

```
SocialSharePlus().copyToClipboard("This is Social Share plugin");
```

#### shareTwitter

```
//without hashtags
SocialSharePlus().shareTwitter("This is Social Share plugin");

//with hashtags
SocialSharePlus().shareTwitter(
                              "This is Social Share twitter example",
                              hashtags: ["hello", "world", "foo", "bar"]);

//with hashtags and link
SocialSharePlus().shareTwitter(
                              "This is Social Share twitter example",
                              hashtags: ["hello", "world", "foo", "bar"],url:"https://your-url-here/");
```

#### shareSms

```
//without url link in message
SocialSharePlus().shareSms("This is Social Share Sms example");

//with url link in message
SocialSharePlus().shareSms("This is Social Share Sms example",url: "https://your-url-here/");
```

#### shareWhatsapp

```
SocialSharePlus().shareWhatsapp("Hello World");
```

#### shareTelegram

```
SocialSharePlus().shareTelegram("Hello World");
```

#### shareOptions

This will open the default native share options

```
//without an image
SocialSharePlus().shareOptions("Hello world");

//with an image
SocialSharePlus().shareOptions("Hello world",imagePath: image.path);
```

#### checkInstalledAppsForShare

```
SocialSharePlus().checkInstalledAppsForShare();
```

# Here's few demo!

## Story share on Instagram

![insta story share demo](demogifs/insta.gif)

## Story share on Facebook

![fb story share demo](demogifs/fbshare.gif)

## Copy to Clipboard

![copy demo](demogifs/copy.gif)

# Known issues

On Android 6, Share to Instagram Stories may not open Instagram app or load the specified image.
