import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../utils/loading_utils.dart';

void showMessagePopup(
  BuildContext context, {
  required String message,
  required String title,
  Function()? onAcceptTap,
  Function()? onRejectTap,
  String? onAccessTitle,
  String? onRejectTitle,
}) {
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
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "JosefinSans",
                    color: CustomColors.WHITE,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            onAcceptTap == null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: customMaterialButton(
                      context: context,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      isLoading: false,
                      text: "Tamam",
                      height: 40,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: customMaterialButton(
                            context: context,
                            onTap: () {
                              Navigator.pop(context);
                              onRejectTap!();
                            },
                            isLoading: false,
                            text: onRejectTitle,
                            height: 40,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: customMaterialButton(
                            context: context,
                            onTap: () {
                              Navigator.pop(context);
                              onAcceptTap();
                            },
                            isLoading: false,
                            text: onAccessTitle,
                            height: 40,
                            backgroundColor: CustomColors.ORANGE,
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
