import 'package:flutter/material.dart';

import '../utils/sizer_utils.dart';

Widget authenticateTextCard(BuildContext context, {required List<Widget> child}) {
  return Hero(
    tag: "CARD",
    flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) => Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color.fromARGB(255, 213, 213, 213)),
      ),
      elevation: 1,
      margin: const EdgeInsets.only(top: 16),
    ),
    child: Material(
      color: Colors.transparent,
      child: Card(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color.fromARGB(255, 213, 213, 213)),
        ),
        elevation: 1,
        margin: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: EdgeInsets.only(bottom: 14, top: (Sizer.getHeight(context) * 0.03) - 6, left: 14, right: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: child,
          ),
        ),
      ),
    ),
  );
}
