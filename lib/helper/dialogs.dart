// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tubes_pinwave/helper/generals.dart';

class Dialogs {
  static Future<void> message({
    required BuildContext buildContext,
    required String title,
    String? message,
    String? dismiss,
    bool showButton = true,
    bool cancelable = true,
  }) {
    Widget? content;

    if (message != null) {
      content = SingleChildScrollView(
        child: Text(message),
      );
    }

    List<Widget> actions = [];

    if (showButton) {
      actions.add(
        TextButton(
          child: Text(dismiss ?? "Mengerti"),
          onPressed: () => Navigator.of(buildContext).pop(),
        ),
      );
    }

    return showDialog(
      context: buildContext,
      barrierDismissible: cancelable,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: actions,
        );
      },
    );
  }

  static Future<void> confirmation({
    required BuildContext context,
    required String title,
    String? message,
    String? negative,
    String? positive,
    bool cancelable = true,
    VoidCallback? negativeCallback,
    VoidCallback? positiveCallback,
  }) {
    Widget? content;

    if (message != null) {
      content = SingleChildScrollView(
        child: Text(message),
      );
    }

    return showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text(negative ?? "Tidak"),
              onPressed: () {
                Navigator.of(buildContext).pop();

                if (negativeCallback != null) {
                  negativeCallback.call();
                }
              },
            ),
            TextButton(
              child: Text(positive ?? "Ya"),
              onPressed: () {
                Navigator.of(buildContext).pop();

                if (positiveCallback != null) {
                  positiveCallback.call();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> tec({
    required BuildContext buildContext,
    required String title,
    String? message,
    String? negative,
    String? positive,
    bool cancelable = true,
    VoidCallback? negativeCallback,
    required void Function(String text) positiveCallback
  }) {
    return showDialog(
        context: buildContext,
        builder: (context) {
          final TextEditingController textEditingController = TextEditingController();

          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                    title: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18
                        )
                    ),
                    content: TextFormField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                            hintText: "Masukkan Text",
                            helperText: message
                        )
                    ),
                    actions: [
                      TextButton(
                          child: Text(negative ?? "Tutup"),
                          onPressed: () {
                            Navigator.of(buildContext).pop();

                            if (negativeCallback != null) {
                              negativeCallback.call();
                            }
                          }
                      ),
                      TextButton(
                          child: Text(positive ?? "Simpan"),
                          onPressed: () {
                            if(textEditingController.text.isNotEmpty) {
                              Navigator.of(buildContext).pop();

                              positiveCallback.call(textEditingController.text);
                            } else {
                              Generals.showSnackBar(context, "Isian tidak boleh kosong", backgroundColor: Colors.red);
                            }
                          }
                      )
                    ]
                );
              }
          );
        }
    );
  }

  static Future<void> changePassword({
    required BuildContext buildContext,
    String? message,
    String? negative,
    String? positive,
    bool cancelable = true,
    VoidCallback? negativeCallback,
    required void Function(String oldPassword, String newPassword, String conPassword) positiveCallback
  }) {
    return showDialog(
        context: buildContext,
        barrierDismissible: false,
        builder: (context) {
          final changePasswordState = GlobalKey<FormState>();
          final TextEditingController tecOldPassword = TextEditingController();
          final TextEditingController tecNewPassword = TextEditingController();
          final TextEditingController tecConPassword = TextEditingController();
          bool pass1 = true;
          bool pass2 = true;
          bool pass3 = true;

          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                    title: const Text(
                        "Ganti Password",
                        style: TextStyle(
                            fontSize: 18
                        )
                    ),
                    content: Form(
                      key: changePasswordState,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: tecOldPassword,
                            obscureText: pass1,
                            decoration: InputDecoration(
                                hintText: "Masukkan Password Lama",
                                helperText: message,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pass1 = !pass1;
                                    });
                                  },
                                  icon: Icon(
                                    pass1 ? Icons.visibility_off : Icons.visibility
                                  )
                                )
                            )
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: tecNewPassword,
                            obscureText: pass2,
                            decoration: InputDecoration(
                                hintText: "Masukkan Password Baru",
                                helperText: message,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        pass2 = !pass2;
                                      });
                                    },
                                    icon: Icon(
                                        pass2 ? Icons.visibility_off : Icons.visibility
                                    )
                                )
                            )
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: tecConPassword,
                            obscureText: pass3,
                            decoration: InputDecoration(
                                hintText: "Masukkan Konfirmasi Password Baru",
                                helperText: message,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        pass3 = !pass3;
                                      });
                                    },
                                    icon: Icon(
                                        pass3 ? Icons.visibility_off : Icons.visibility
                                    )
                                )
                            )
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          child: Text(negative ?? "Tutup"),
                          onPressed: () {
                            Navigator.of(buildContext).pop();

                            if (negativeCallback != null) {
                              negativeCallback.call();
                            }
                          }
                      ),
                      TextButton(
                          child: Text(positive ?? "Simpan"),
                          onPressed: () {
                            if(tecOldPassword.text.isNotEmpty || tecNewPassword.text.isNotEmpty || tecConPassword.text.isNotEmpty) {
                              positiveCallback.call(tecOldPassword.text, tecNewPassword.text, tecConPassword.text);
                            } else {
                              Generals.showSnackBar(context, "Isian tidak boleh kosong", backgroundColor: Colors.red);
                            }
                          }
                      )
                    ]
                );
              }
          );
        }
    );
  }
}