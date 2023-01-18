import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/view/auth/login/login_view.dart';
import 'package:flutter/material.dart';

import '../../view/auth/register/register_view.dart';
import '../constants/app_constants.dart';

Widget authenticationTabs({required BuildContext context, int? index, required bool isLoading}) {
  return Hero(
    tag: "TABS",
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: index != null && index == 0 ? CustomColors.OFF_WHITE : CustomColors.WHITE,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          elevation: 1,
          child: InkWell(
            onTap: isLoading
                ? null
                : () {
                    if (index != 0) {
                      NavigateUtils.pushAndRemoveUntil(context, page: LoginView());
                    }
                  },
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                border: Border.all(
                  color: CustomColors.DARK_WHITE,
                  strokeAlign: StrokeAlign.center,
                  width: 0.75,
                ),
              ),
              child: Text(
                "Giriş Yap",
                style: index != null && index == 0
                    ? const TextStyle(
                        color: CustomColors.BLACK,
                        fontWeight: FontWeight.w500,
                        fontFamily: "JosefinSans",
                        fontSize: 14,
                      )
                    : const TextStyle(
                        color: CustomColors.LIGHT_BLACK,
                        fontWeight: FontWeight.w400,
                        fontFamily: "JosefinSans",
                        fontSize: 14,
                      ),
              ),
            ),
          ),
        ),
        Material(
          color: index != null && index == 1 ? CustomColors.OFF_WHITE : CustomColors.WHITE,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          elevation: 1,
          child: InkWell(
            onTap: isLoading
                ? null
                : () {
                    if (index != 1) {
                      NavigateUtils.pushAndRemoveUntil(context, page: RegisterView());
                    }
                  },
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                border: Border.all(
                  color: CustomColors.DARK_WHITE,
                  strokeAlign: StrokeAlign.center,
                  width: 0.75,
                ),
              ),
              child: Text(
                "Kayıt Ol",
                style: index != null && index == 1
                    ? const TextStyle(
                        color: CustomColors.BLACK,
                        fontWeight: FontWeight.w500,
                        fontFamily: "JosefinSans",
                        fontSize: 14,
                      )
                    : const TextStyle(
                        color: CustomColors.LIGHT_BLACK,
                        fontWeight: FontWeight.w400,
                        fontFamily: "JosefinSans",
                        fontSize: 14,
                      ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
