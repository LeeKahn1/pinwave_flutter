// ignore_for_file: always_specify_types, prefer_const_constructors_in_immutables

import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class LoadingFail extends StatelessWidget {
  LoadingFail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lottie/loading_fail.json",
            frameRate: FrameRate(60),
            width: 300,
            repeat: true,
          ),
          Text(
            "Gagal memuat data",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Silahkan swipe ke bawah untuk memuat ulang",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
