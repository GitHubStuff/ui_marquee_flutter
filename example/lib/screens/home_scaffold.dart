// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:ui_marquee_flutter/ui_marguee_flutter.dart';

import '../gen/assets.gen.dart';

const String message =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.ltmm1024x1024.image(),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: UIMarqueeWidget(
              message: message,
              textStyle: TextStyle(fontSize: 28.0),
            ),
          )
        ],
      ),
    );
  }
}
