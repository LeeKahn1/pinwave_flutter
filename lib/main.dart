import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:tubes_pinwave/api/custom_http_overrides.dart';
import 'package:tubes_pinwave/constant.dart';
import 'package:tubes_pinwave/helper/navigators.dart';
import 'package:tubes_pinwave/helper/preferences.dart';
import 'package:tubes_pinwave/module/album/album_bloc.dart';
import 'package:tubes_pinwave/module/create_pin/create_pin_bloc.dart';
import 'package:tubes_pinwave/module/edit_profile/edit_profile_bloc.dart';
import 'package:tubes_pinwave/module/home/home_bloc.dart';
import 'package:tubes_pinwave/module/nav_menu/nav_menu_bloc.dart';
import 'package:tubes_pinwave/module/nav_menu/nav_menu_page.dart';
import 'package:tubes_pinwave/module/notification/notification_bloc.dart';
import 'package:tubes_pinwave/module/pin_detail/pin_detail_bloc.dart';
import 'package:tubes_pinwave/module/profile/profile_bloc.dart';
import 'package:tubes_pinwave/module/search/search_bloc.dart';
import 'package:tubes_pinwave/module/sign_in/sign_in_bloc.dart';
import 'package:tubes_pinwave/module/sign_up/sign_up_bloc.dart';
import 'package:tubes_pinwave/module/welcome/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = CustomHttpOverrides();

  initializeDateFormatting();

  await Preferences.getInstance().init();


  runApp(const PinWave());
}

class PinWave extends StatelessWidget {
  const PinWave({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SignInBloc()),
        BlocProvider(create: (BuildContext context) => SignUpBloc()),
        BlocProvider(create: (BuildContext context) => SearchBloc()),
        BlocProvider(create: (BuildContext context) => NotificationBloc()),
        BlocProvider(create: (BuildContext context) => NavMenuBloc()),
        BlocProvider(create: (BuildContext context) => HomeBloc()),
        BlocProvider(create: (BuildContext context) => CreatePinBloc()),
        BlocProvider(create: (BuildContext context) => ProfileBloc()),
        BlocProvider(create: (BuildContext context) => AlbumBloc()),
        BlocProvider(create: (BuildContext context) => PinDetailBloc()),
        BlocProvider(create: (BuildContext context) => EditProfileBloc()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/lottie/loading_clock.json",
                frameRate: FrameRate(60),
                width: 200,
                repeat: true,
              ),
              const Text(
                "Memuat Data...",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        child: DismissKeyboard(
          child: MaterialApp(
            title: 'Pin Wave',
            debugShowCheckedModeBanner: false,
            navigatorKey: Navigators.navigatorState,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            home: home(),
          ),
        ),
      ),
    );
  }

  Widget home() {
    if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      return const NavMenuPage();
    } else {
      return const WelcomePage();
    }
  }
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
