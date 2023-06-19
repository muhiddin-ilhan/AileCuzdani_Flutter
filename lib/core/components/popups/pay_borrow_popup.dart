// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';

Future<bool?> showPayBorrowPopup(BuildContext context) async {
  List<Widget> getMontlyPriceArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Aylık Taksit Tutarı",
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
          minWidthPrefix: 40,
          maxLength: 8,
          suffixIcon: const Icon(Icons.currency_lira_rounded),
        ),
      ),
    ];
  }

  List<Widget> getTotalBorrowArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Toplam Borç",
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
          height: 36,
          contentPaddingHorizontal: 12,
          hintText: "0",
          minWidthPrefix: 40,
          inputType: TextInputType.number,
          maxLength: 8,
          suffixIcon: const Icon(Icons.currency_lira_rounded),
        ),
      ),
    ];
  }

  List<Widget> getPayDayArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Ödeme Günü (1-31)",
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
          height: 36,
          contentPaddingHorizontal: 12,
          hintText: "0",
          minWidthPrefix: 40,
          inputType: TextInputType.number,
          maxLength: 2,
          suffixIcon: const Icon(Icons.date_range),
        ),
      ),
    ];
  }

  List<Widget> getTaksitNumberArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Taksit Sayısı",
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
          height: 36,
          contentPaddingHorizontal: 12,
          hintText: "0",
          minWidthPrefix: 40,
          inputType: TextInputType.number,
          maxLength: 3,
        ),
      ),
    ];
  }

  List<Widget> getPaidTaksitArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Ödenen Taksit Sayısı",
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
          height: 36,
          contentPaddingHorizontal: 12,
          hintText: "0",
          minWidthPrefix: 40,
          inputType: TextInputType.number,
          maxLength: 3,
        ),
      ),
    ];
  }

  List<Widget> getDescriptionArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Borç Adı",
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
          height: 36,
          contentPaddingHorizontal: 12,
          hintText: "Buraya Yazınız",
          minWidthPrefix: 40,
          maxLength: 20,
        ),
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
                ...getMontlyPriceArea(setState),
                ...getTotalBorrowArea(setState),
                ...getPayDayArea(setState),
                ...getTaksitNumberArea(setState),
                ...getPaidTaksitArea(setState),
                ...getDescriptionArea(setState),
                button(
                  context,
                  loading: false,
                  onClear: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context, true);
                    }
                  },
                  onTap: () async {
                    LoadingUtils.instance.loading(true);

                    LoadingUtils.instance.loading(false);

                    if (Navigator.canPop(context)) {
                      Navigator.pop(context, true);
                    }
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
        "Borç Ekle",
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

Widget button(BuildContext context,
    {required Function() onTap,
    required Function() onClear,
    required bool loading}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: customMaterialButton(
            context: context,
            onTap: onTap,
            isLoading: loading,
            text: "Tamamla",
            height: 35,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: customMaterialButton(
            context: context,
            onTap: onTap,
            isLoading: loading,
            backgroundColor: CustomColors.DARK_ORANGE,
            text: "Öde",
            height: 35,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: customMaterialButton(
            context: context,
            onTap: onTap,
            isLoading: loading,
            backgroundColor: CustomColors.WHITE,
            child: const Icon(Icons.delete),
            height: 35,
          ),
        ),
      ],
    ),
  );
}
