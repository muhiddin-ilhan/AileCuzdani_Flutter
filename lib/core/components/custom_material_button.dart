import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../utils/sizer_utils.dart';

Widget customMaterialButton({
  required BuildContext context,
  required VoidCallback? onTap,
  String? text,
  Widget? child,
  required bool isLoading,
  bool enabled = true,
  bool enableLoadingAnim = true,
  double? width,
  double? height,
  Color? backgroundColor,
  Color? disableBackgroundColor,
  double? elevation,
  TextStyle? textStyle,
  bool isFullWidth = true,
}) {
  return SizedBox(
    height: height ?? Sizer.getHeight(context) * 0.05,
    width: width,
    child: MaterialButton(
      onPressed: isLoading || !enabled ? null : onTap,
      color: backgroundColor ?? CustomColors.GREY,
      elevation: elevation ?? 3,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: backgroundColor ?? CustomColors.GREY),
      ),
      disabledColor: disableBackgroundColor ?? CustomColors.DARK_GREY,
      disabledElevation: 0,
      child: isLoading && enableLoadingAnim
          ? Center(
              child: SizedBox(
                height: Sizer.getHeight(context) * 0.02,
                width: Sizer.getHeight(context) * 0.02,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: CustomColors.WHITE,
                ),
              ),
            )
          : text != null
              ? isFullWidth
                  ? Center(
                      child: Text(
                        text,
                        style: textStyle ??
                            const TextStyle(
                              color: CustomColors.WHITE,
                              fontFamily: "JosefinSans",
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              letterSpacing: 0.7,
                            ),
                      ),
                    )
                  : Text(
                      text,
                      style: textStyle ??
                          const TextStyle(
                            color: CustomColors.WHITE,
                            fontFamily: "JosefinSans",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            letterSpacing: 0.7,
                          ),
                    )
              : child,
    ),
  );
}
