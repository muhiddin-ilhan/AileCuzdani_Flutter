import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

Tooltip customTooltip({required String message, required Widget child}) {
  return Tooltip(
    message: message,
    margin: const EdgeInsets.symmetric(horizontal: 28),
    triggerMode: TooltipTriggerMode.tap,
    showDuration: const Duration(seconds: 5),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: CustomColors.DARK_GREY,
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  );
}
