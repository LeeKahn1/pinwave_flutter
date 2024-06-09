import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tubes_pinwave/constant.dart";
import "package:tubes_pinwave/helper/dialogs.dart";
import "package:tubes_pinwave/helper/generals.dart";
import "package:tubes_pinwave/helper/navigators.dart";
import "package:tubes_pinwave/helper/preferences.dart";
import "package:tubes_pinwave/overlay/overlays.dart";

class AuthorizationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      options.headers["Authorization"] = "Bearer ${Preferences.getInstance().getString(SharedPreferenceKey.SESSION_ID)}";
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null && err.response!.statusCode == 401) {
      BuildContext? buildContext = Navigators.navigatorState.currentContext;

      if (buildContext != null) {
        await Dialogs.message(
          buildContext: buildContext,
          title: "Sesi Berakhir",
          message: "Anda akan diarahkan ke halaman Welcome"
        );

        Generals.signOut();
      }


      return handler.next(err);
    } else {
      Overlays.error(message: err.response?.data.toString() ?? "Ada sesuatu yang salah.\nCobalah beberapa saat lagi!");

      return handler.next(err);
    }
  }
}
