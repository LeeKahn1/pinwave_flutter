// ignore_for_file: always_specify_types, prefer_const_constructors_in_immutables

import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class NoData extends StatelessWidget {
  NoData({
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
            "assets/lottie/no_data.json",
            frameRate: FrameRate(60),
            width: 300,
            repeat: true,
          ),
          const Text(
            "Tidak ada data",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Data mungkin saja memang tidak ada atau silahkan lakukan pencarian data menggunakan kata pencarian dan periode yang berbeda",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
