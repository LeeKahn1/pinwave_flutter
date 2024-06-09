import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tubes_pinwave/api/endpoint/sign_in/sign_in_request.dart';
import 'package:tubes_pinwave/constant.dart';
import 'package:tubes_pinwave/helper/dialogs.dart';
import 'package:tubes_pinwave/helper/navigators.dart';
import 'package:tubes_pinwave/helper/preferences.dart';
import 'package:tubes_pinwave/module/nav_menu/nav_menu_page.dart';
import 'package:tubes_pinwave/module/sign_in/sign_in_bloc.dart';
import 'package:tubes_pinwave/module/sign_up/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInClickedLoading) {
          context.loaderOverlay.show();
        } else if (state is SignInClickedSuccess) {
          Navigators.pushAndRemoveAll(context, NavMenuPage());
        } else if (state is SignInClickedFinished) {
          context.loaderOverlay.hide();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Dialogs.tec(
                            buildContext: context,
                            title: "Awali dengan http:// dan akhiri dengan /api/",
                            positiveCallback: (text) {
                              Preferences.getInstance().setString(SharedPreferenceKey.BASE_URL, text.toLowerCase());
                            },
                          );
                        },
                        child: Image.asset('assets/logo.jpeg', // Ganti dengan URL logo Anda
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'PINWAVE',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sign in with your data that you have entered during your registration',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: tecUsername,
                        decoration: const InputDecoration(
                          labelText: 'UserName',
                          labelStyle: TextStyle(color: Colors.blue),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: tecPassword,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.blue),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child: const Text(
                      //       'Forgot password?',
                      //       style: TextStyle(color: Colors.blue),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          context.read<SignInBloc>().add(SignInClick(
                              signInRequest: SignInRequest(
                                username: tecUsername.text,
                                password: tecPassword.text,
                              )
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: Colors.blue.shade900, // Button color
                        ),
                        child: const Text('Sign In'),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpPage()),
                              );
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}