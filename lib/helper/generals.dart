// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:tubes_pinwave/constant.dart";
import "package:tubes_pinwave/helper/navigators.dart";
import "package:tubes_pinwave/helper/preferences.dart";
import "package:tubes_pinwave/module/welcome/welcome_page.dart";
import "package:tubes_pinwave/overlay/overlays.dart";

class Generals {
  static void signOut() async {
    if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      BuildContext? buildContext = Navigators.navigatorState.currentContext;

      await Preferences.getInstance().remove(SharedPreferenceKey.SESSION_ID);

      if (buildContext != null) {
        Navigators.pushAndRemoveAll(buildContext, const WelcomePage());
      }
    }
  }

  static Future<String> appVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  static void checkSession(BuildContext context) async {
    Preferences.getInstance().reload();

    if (!Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      await Overlays.error(message: "Sesi telah habis");

      Navigators.pushAndRemoveAll(context, const WelcomePage());
    }
  }

  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.green, margin: const EdgeInsets.only(left: 10, bottom: 10, right: 10),)
    );
  }
}
