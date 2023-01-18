import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import 'custom_material_button.dart';

Widget errorPageWidget(BuildContext context, {String? message, required Function() onReloadTap}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(width: double.infinity),
                  const Icon(
                    Icons.warning_amber,
                    size: 50,
                    color: CustomColors.ORANGE,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      message ?? "Sayfa Yüklenirken Bir Hata Meydana Geldi, Lütfen Daha Sonra Tekrar Deneyiniz",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: customMaterialButton(
            context: context,
            onTap: onReloadTap,
            isLoading: false,
            height: 40,
            text: "Tekrar Dene",
          ),
        ),
      ],
    ),
  );
}
