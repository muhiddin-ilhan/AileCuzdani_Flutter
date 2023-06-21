// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/popups/borrows_pay_borrow_popup.dart';
import 'package:aile_cuzdani/core/components/popups/credit_card_pay_borrow_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../utils/loading_utils.dart';

Future<bool?> showMainPayBorrowPopup(BuildContext context) async {
  return showDialog<bool?>(
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
                  "Hakkında",
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  customMaterialButton(
                    context: context,
                    onTap: () async {
                      bool? result = await showCreditCardPayBorrowPopup(context);
                      Navigator.pop(context, result ?? false);
                    },
                    isLoading: false,
                    text: "Kredi Kartı Borcu Öde",
                    backgroundColor: CustomColors.GREEN,
                    textStyle: const TextStyle(
                      color: CustomColors.WHITE,
                      fontFamily: "JosefinSans",
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  customMaterialButton(
                    context: context,
                    onTap: () async {
                      bool? result = await showBorrowsPayBorrowPopup(context);
                      Navigator.pop(context, result ?? false);
                    },
                    isLoading: false,
                    text: "Diğer Borç Ödeme",
                    backgroundColor: CustomColors.DARK_ORANGE,
                    textStyle: const TextStyle(
                      color: CustomColors.WHITE,
                      fontFamily: "JosefinSans",
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                  ),
                ],
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
                      text: "İptal",
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
