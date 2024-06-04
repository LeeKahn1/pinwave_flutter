// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tubes_pinwave/helper/navigators.dart';
import 'package:tubes_pinwave/widgets/camera_page.dart';

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

  static Future<void> image({
    required BuildContext context,
    required String title,
    required bool multiple,
    required bool allowGallery,
    required void Function(List<Uint8List> files) callback,
  }) async {
    if (allowGallery) {
      List<Widget> actions = [
        TextButton(
          child: const Text("Tutup"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ];

      BoxDecoration boxDecoration = BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      );

      await showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: const Text("Pilih Sumber Foto"),
            content: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: boxDecoration,
                    child: InkWell(
                      onTap: () async {
                        List<Uint8List> files = [];

                        List<XFile> xFiles = await ImagePicker().pickMultiImage(
                          imageQuality: 20,
                        );

                        for (XFile xFile in xFiles) {
                          Uint8List bytesFile = Uint8List.fromList(await xFile.readAsBytes());

                          files.add(
                            bytesFile,
                          );
                        }

                        Navigators.pop(context);

                        callback.call(files);
                      },
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.photo), Text("Galeri")],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: boxDecoration,
                    child: InkWell(
                      onTap: () async {
                        List<Uint8List> byteList = [];

                        await availableCameras().then((value) {
                          Navigators.push(
                            context,
                            CameraPage(
                              cameraDescriptions: value,
                              callback: (bytes) async {
                                byteList.add(
                                  bytes,
                                );

                                Navigators.pop(context);

                                callback.call(byteList);
                              },
                            ),
                          );
                        });
                      },
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.camera_alt), Text("Kamera")],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: actions,
          );
        },
      );
    } else {
      List<Uint8List> byteList = [];

      await availableCameras().then((value) {
        Navigators.push(
          context,
          CameraPage(
            cameraDescriptions: value,
            callback: (bytes) async {
              byteList.add(
                bytes,
              );

              callback.call(byteList);
            },
          ),
        );
      });
    }
  }
}