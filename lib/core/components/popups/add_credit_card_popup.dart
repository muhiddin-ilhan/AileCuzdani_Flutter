// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/components/custom_tooltip.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';

Future<bool?> showAddCreditCardPopup(BuildContext context, {bool isEditing = false, DTOBucket? bucket}) async {
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardLimitController = TextEditingController();
  TextEditingController cardBorrowController = TextEditingController();
  TextEditingController cardLastDayController = TextEditingController();

  bool isShowMyAssets = true;

  String? errorTitleName = "";
  String? errorTitleLimit = "";
  String? errorTitleBorrow = "";
  String? errorTitleLastDay = "";

  if (bucket != null) {
    cardNameController.text = bucket.title ?? "";
    cardLimitController.text = (bucket.credit_card_limit ?? 0.0).toString();
    cardBorrowController.text = (bucket.credit_card_borrow ?? 0.0).toString();
    cardLastDayController.text = (bucket.credit_card_pay_day ?? 0.0).toString();
    isShowMyAssets = bucket.show_my_assets == 1;

    errorTitleName = cardNameController.text.alphanumericValidation() ? null : "";
    errorTitleLimit = (bucket.credit_card_limit ?? 0) < 0 ? "" : null;
    errorTitleBorrow = (bucket.credit_card_borrow ?? 0) < 0 ? "" : null;
    errorTitleLastDay = ((bucket.credit_card_pay_day ?? -1) < 32 && (bucket.credit_card_pay_day ?? -1) > 0) ? null : "";
  }

  List<Widget> cardNameArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Kart Adı",
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
          borderRadius: 8,
          fontSize: 12,
          height: 40,
          contentPaddingHorizontal: 12,
          hintText: "Buraya Yazınız",
          minWidthPrefix: 40,
          maxLength: 30,
          inputType: TextInputType.text,
          isCapitalizeSentence: true,
          textInputAction: TextInputAction.next,
          suffixIcon: cardNameController.text.isNotEmpty && errorTitleName != null
              ? customTooltip(message: "Geçerli Bir Ad Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          controller: cardNameController,
          onChanged: (text) {
            errorTitleName = text.alphanumericValidation() ? null : "";
            setState(() {});
          },
        ),
      ),
    ];
  }

  List<Widget> cardLimitArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Kart Limiti",
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
          hintText: "0",
          minWidthPrefix: 40,
          maxLength: 12,
          inputType: TextInputType.number,
          textInputAction: TextInputAction.next,
          controller: cardLimitController,
          suffixIcon: cardLimitController.text.isNotEmpty && errorTitleLimit != null
              ? customTooltip(message: "Lütfen Geçerli Limit Giriniz", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            double limit = double.tryParse(text) ?? -1;
            errorTitleLimit = limit < 0 ? "" : null;
            setState(() {});
          },
        ),
      ),
    ];
  }

  List<Widget> cardBorrowArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Kart Borcu",
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
          hintText: "0",
          minWidthPrefix: 40,
          maxLength: 12,
          controller: cardBorrowController,
          inputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          suffixIcon: cardBorrowController.text.isNotEmpty && errorTitleBorrow != null
              ? customTooltip(message: "Lütfen Geçerli Borç Giriniz", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            double limit = double.tryParse(text) ?? -1;
            errorTitleBorrow = limit < 0 ? "" : null;
            setState(() {});
          },
        ),
      ),
    ];
  }

  List<Widget> cardLastDayArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Son Ödeme Günü (1-31)",
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
          hintText: "0",
          minWidthPrefix: 40,
          maxLength: 12,
          inputType: TextInputType.number,
          textInputAction: TextInputAction.next,
          controller: cardLastDayController,
          suffixIcon: cardLastDayController.text.isNotEmpty && errorTitleLastDay != null
              ? customTooltip(message: "Lütfen Geçerli Sayı Giriniz", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            int limit = int.tryParse(text) ?? -1;
            errorTitleLastDay = (limit < 32 && limit > 0) ? null : "";
            setState(() {});
          },
        ),
      ),
    ];
  }

  Widget showMyAssetsToggle(Function(void Function()) setState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 10, 3, 0),
      child: Row(
        children: [
          const Text(
            "Varlıklarıma Dahil Et",
            style: TextStyle(
              fontFamily: "JosefinSans",
              color: Color.fromARGB(255, 33, 33, 33),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Switch(
            value: isShowMyAssets,
            activeColor: CustomColors.GREEN,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (val) {
              isShowMyAssets = val;
              setState(() {});
            },
          )
        ],
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
          if (isEditing) const SizedBox(width: 6),
          if (isEditing)
            customMaterialButton(
              context: context,
              onTap: onClear,
              isLoading: false,
              enableLoadingAnim: false,
              child: const Icon(Icons.delete_outline, color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 148, 54, 54),
              height: 40,
            ),
        ],
      ),
    );
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
                ...cardNameArea(setState),
                ...cardLimitArea(setState),
                ...cardBorrowArea(setState),
                ...cardLastDayArea(setState),
                if (isEditing) showMyAssetsToggle(setState),
                button(
                  context,
                  enabled: errorTitleName == null &&
                      errorTitleLimit == null &&
                      errorTitleBorrow == null &&
                      ((double.tryParse(cardLimitController.text) ?? 0.0) > (double.tryParse(cardBorrowController.text) ?? 0.0)) &&
                      ((int.tryParse(cardLastDayController.text) ?? 0) > 0 && (int.tryParse(cardLastDayController.text) ?? 0) < 32),
                  onClear: () async {
                    LoadingUtils.instance.loading(true);

                    DTOBucket request = DTOBucket(
                      id: bucket?.id,
                    );

                    bool response = await BucketServices.deleteBucket(request);

                    if (response) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
                    }

                    LoadingUtils.instance.loading(false);
                  },
                  onTap: () async {
                    double limit = double.tryParse(cardLimitController.text) ?? 0.0;
                    double borrow = double.tryParse(cardBorrowController.text) ?? 0.0;
                    String name = cardNameController.text;

                    LoadingUtils.instance.loading(true);

                    DTOBucket request = DTOBucket(
                      id: bucket?.id,
                      title: name,
                      credit_card_borrow: borrow,
                      credit_card_limit: limit,
                      show_my_assets: isShowMyAssets ? 1 : 0,
                      credit_card_pay_day: int.tryParse(cardLastDayController.text) ?? 1,
                      credit_card_last_pay_month: DateTime.now().month < 12 ? DateTime.now().month + 1 : 1,
                      type: 1,
                    );

                    bool response;
                    if (bucket != null) {
                      response = await BucketServices.editBucket(request);
                    } else {
                      response = await BucketServices.createBucket(request);
                    }

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
        "Kredi Kartı",
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
