import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

void customSnackBar(BuildContext ctx, {required String message, bool? isError}) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: CustomColors.GREEN,
      elevation: 3,
      behavior: SnackBarBehavior.floating,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CustomColors.GREEN),
      ),
      action: SnackBarAction(
        label: 'Kapat',
        textColor: CustomColors.VERY_DARK_GREEN,
        onPressed: () {
          try {
            ScaffoldMessenger.of(ctx).clearSnackBars();
          } catch (e) {
            debugPrint(e.toString());
          }
        },
      ),
    ),
  );
}
