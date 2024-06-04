import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:tubes_pinwave/api/custom_http_overrides.dart';
import 'package:tubes_pinwave/helper/navigators.dart';
import 'package:tubes_pinwave/helper/preferences.dart';
import 'package:tubes_pinwave/module/sign_in/sign_in_bloc.dart';
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
            home: const WelcomePage(),
          ),
        ),
      ),
    );
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
