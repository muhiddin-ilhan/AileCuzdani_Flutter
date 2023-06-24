import 'dart:io';

import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../utils/loading_utils.dart';

void showAppUpdatePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        if (LoadingUtils.instance.isLoadingActive()) return false;

        return true;
      },
      child: Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: CustomColors.OFF_WHITE,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: CustomColors.GREEN,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  "Versiyon Hatası",
                  style: TextStyle(
                    fontFamily: "JosefinSans",
                    color: CustomColors.WHITE,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Uygulamanın Yeni Sürümü Mevcuttur, Lütfen Uygulamayı Güncelleyip Tekrar Deneyiniz",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "JosefinSans",
                  letterSpacing: 0.1,
                  height: 1.3,
                  color: Color.fromARGB(255, 48, 48, 48),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: customMaterialButton(
                      context: context,
                      onTap: () {
                        exit(0);
                      },
                      isLoading: false,
                      text: "Tamam",
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
