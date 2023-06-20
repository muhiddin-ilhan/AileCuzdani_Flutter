// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/borrow/borrow_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/components/custom_tooltip.dart';
import 'package:aile_cuzdani/core/components/dropdowns/borrow_dropdown.dart';
import 'package:aile_cuzdani/core/components/dropdowns/bucket_dropdown.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_borrow.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<bool?> showBorrowsPayBorrowPopup(BuildContext context) async {
  DTOBucket? selectedBankAccount;
  DTOBorrow? selectedBorrow;
  TextEditingController moneyController = TextEditingController();

  String? moneyError = "";

  Provider.of<BucketProvider>(context, listen: false).getBorrows(context);

  Provider.of<BucketProvider>(context, listen: false).getBuckets(context);

  List<Widget> getSelectCreditCardArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Ödenecek Borç",
          style: TextStyle(
            fontFamily: "JosefinSans",
            color: Color.fromARGB(255, 81, 81, 81),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
        child: Consumer<BucketProvider>(builder: (_, providerBucket, __) {
          return borrowDropdown(
            onSelected: (DTOBorrow? borrow) {
              selectedBorrow = borrow;
              if (borrow != null) {
                moneyController.text = (borrow.monthly_price ?? 0).toString();
                moneyError = (double.tryParse(moneyController.text) ?? -1) < 0 ? "" : null;
              }
              setState(() {});
            },
            items: providerBucket.borrows,
            height: 40,
            value: selectedBorrow,
            loading: providerBucket.isLoading,
          );
        }),
      ),
    ];
  }

  List<Widget> getGoldCountArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Tutar",
          style: TextStyle(
            fontFamily: "JosefinSans",
            color: Color.fromARGB(255, 81, 81, 81),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
        child: customTextbox(
          context,
          isMinusNumber: true,
          isNumber: true,
          borderRadius: 8,
          fontSize: 12,
          height: 40,
          contentPaddingHorizontal: 12,
          inputType: TextInputType.number,
          hintText: "0",
          controller: moneyController,
          suffixIcon: moneyController.text.isNotEmpty && moneyError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            double val = double.tryParse(text) ?? -1;
            moneyError = val < 0 ? "" : null;
            setState(() {});
          },
          minWidthPrefix: 40,
          maxLength: 12,
        ),
      ),
    ];
  }

  List<Widget> getSelectCardArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Borcu Ödeyecek Hesap",
          style: TextStyle(
            fontFamily: "JosefinSans",
            color: Color.fromARGB(255, 81, 81, 81),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
        child: Consumer<BucketProvider>(builder: (_, providerBucket, __) {
          return bucketDropdown(
            onSelected: (DTOBucket? bucket) {
              selectedBankAccount = bucket;
              setState(() {});
            },
            items: providerBucket.buckets,
            height: 40,
            value: selectedBankAccount,
            loading: providerBucket.isLoading,
          );
        }),
      ),
    ];
  }

  return showDialog<bool?>(
    context: context,
    builder: (_) => StatefulBuilder(builder: (_, setState) {
      return WillPopScope(
        onWillPop: () async {
          if (LoadingUtils.instance.isLoadingActive()) return false;

          return true;
        },
        child: Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: CustomColors.OFF_WHITE,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(),
                ...getSelectCreditCardArea(setState),
                ...getGoldCountArea(setState),
                ...getSelectCardArea(setState),
                button(
                  context,
                  enabled: selectedBankAccount != null && selectedBorrow != null && ((double.tryParse(moneyController.text) ?? 0.0) > 0),
                  onClear: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context, true);
                    }
                  },
                  onTap: () async {
                    LoadingUtils.instance.loading(true);

                    bool response = await BorrowServices.payBorrow(
                      borrowId: selectedBorrow!.id!,
                      money: double.tryParse(moneyController.text) ?? 0,
                      cekilecekHesapId: selectedBankAccount!.id!,
                    );

                    if (response) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
                    }

                    LoadingUtils.instance.loading(false);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

Container appBar() {
  return Container(
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
        "Borç Ödeme",
        style: TextStyle(
          fontFamily: "JosefinSans",
          color: CustomColors.WHITE,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Padding button(BuildContext context, {required Function() onTap, required Function() onClear, required bool enabled}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Expanded(
          child: customMaterialButton(
            context: context,
            onTap: onTap,
            isLoading: false,
            enabled: enabled,
            text: "Tamamla",
            height: 40,
          ),
        ),
      ],
    ),
  );
}
