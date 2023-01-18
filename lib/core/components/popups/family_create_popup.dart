import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../utils/loading_utils.dart';

void showFamilyCreatePopup(BuildContext context, {required Function() onAcceptTap, required TextEditingController controller}) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Aile Oluştur",
                  style: TextStyle(
                    fontFamily: "JosefinSans",
                    color: CustomColors.WHITE,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 12, right: 12, top: 24),
              child: customTextbox(
                context,
                borderRadius: 12,
                hintText: "Aile Adı",
                isCapitalizeSentence: true,
                fontSize: 14,
                prefixIcon: const Icon(Icons.group_add),
                textInputAction: TextInputAction.done,
                maxLength: 30,
                controller: controller,
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
                        Navigator.pop(context);
                      },
                      isLoading: false,
                      text: "Vazgeç",
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
                      text: "Oluştur",
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
