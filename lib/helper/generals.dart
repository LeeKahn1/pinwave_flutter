// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import "package:tubes_pinwave/constant.dart";
import "package:tubes_pinwave/helper/navigators.dart";
import "package:tubes_pinwave/helper/preferences.dart";
import "package:tubes_pinwave/module/sign_in/sign_in_page.dart";
import "package:tubes_pinwave/overlay/overlays.dart";

class Generals {
  static void signOut() async {
    if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      BuildContext? buildContext = Navigators.navigatorState.currentContext;

      await Preferences.getInstance().remove(SharedPreferenceKey.SESSION_ID);
      await Preferences.getInstance().remove(SharedPreferenceKey.USERNAME);
      await Preferences.getInstance().remove(SharedPreferenceKey.BASE_URL);

      if (buildContext != null) {
        Navigators.pushAndRemoveAll(buildContext, const SignInPage());
      }
    }
  }

  static void checkSession(BuildContext context) async {
    Preferences.getInstance().reload();

    if (!Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      await Overlays.error(message: "Sesi telah habis");

      await Preferences.getInstance().remove(SharedPreferenceKey.BASE_URL);

      Navigators.pushAndRemoveAll(context, const SignInPage());
    }
  }

  static void showSnackBar(BuildContext context, String text, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text, style: const TextStyle(color: Colors.white)), backgroundColor: backgroundColor ?? Colors.green, behavior: SnackBarBehavior.floating)
    );
  }
}
