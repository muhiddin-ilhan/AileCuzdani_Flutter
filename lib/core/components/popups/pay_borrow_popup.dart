// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/borrow/borrow_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/components/custom_tooltip.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/model/dto_borrow.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';

Future<bool?> showPayBorrowPopup(BuildContext context, {DTOBorrow? borrow}) async {
  TextEditingController monthlyPriceController = TextEditingController();
  TextEditingController totalBorrowController = TextEditingController();
  TextEditingController payDayController = TextEditingController();
  TextEditingController taksitNumberController = TextEditingController();
  TextEditingController paidTaksitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? monthlyPriceError = "";
  String? totalBorrowError = "";
  String? payDayError = "";
  String? taksitNumberError = "";
  String? paidTaksitError = "";
  String? descriptionError = "";

  if (borrow != null) {
    monthlyPriceController.text = (borrow.monthly_price ?? 0).toString();
    totalBorrowController.text = (borrow.total_borrow ?? 0).toString();
    payDayController.text = (borrow.pay_day ?? 0).toString();
    taksitNumberController.text = (borrow.total_taksit_count ?? 0).toString();
    paidTaksitController.text = (borrow.paid_taksit ?? 0).toString();
    descriptionController.text = (borrow.title ?? 0).toString();

    monthlyPriceError = (double.tryParse(monthlyPriceController.text) ?? -1) < 1 ? "" : null;
    totalBorrowError = (double.tryParse(totalBorrowController.text) ?? -1) < 1 ? "" : null;
    payDayError = (double.tryParse(payDayController.text) ?? -1) < 1 || (double.tryParse(payDayController.text) ?? -1) > 31 ? "" : null;
    taksitNumberError = (double.tryParse(taksitNumberController.text) ?? -1) < 1 ? "" : null;
    paidTaksitError = (double.tryParse(paidTaksitController.text) ?? -1) < 1 ? "" : null;
    descriptionError = descriptionController.text.alphanumericValidation() ? null : "";
  }

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
          controller: monthlyPriceController,
          suffixIcon: monthlyPriceController.text.isNotEmpty && monthlyPriceError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : const Icon(Icons.currency_lira_rounded),
          onChanged: (text) {
            monthlyPriceError = (double.tryParse(text) ?? -1) < 1 ? "" : null;
            setState(() {});
          },
          hintText: "0",
          minWidthPrefix: 40,
          maxLength: 8,
        ),
      ),
    ];
  }

  List<Widget> getTotalBorrowArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Kalan Borç",
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
          controller: totalBorrowController,
          suffixIcon: totalBorrowController.text.isNotEmpty && totalBorrowError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : const Icon(Icons.currency_lira_rounded),
          onChanged: (text) {
            totalBorrowError = (double.tryParse(text) ?? -1) < 1 ? "" : null;
            setState(() {});
          },
          maxLength: 8,
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
          controller: payDayController,
          suffixIcon: payDayController.text.isNotEmpty && payDayError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : const Icon(Icons.date_range),
          onChanged: (text) {
            payDayError = (double.tryParse(text) ?? -1) < 1 || (double.tryParse(text) ?? -1) > 31 ? "" : null;
            setState(() {});
          },
          maxLength: 2,
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
          controller: taksitNumberController,
          suffixIcon: taksitNumberController.text.isNotEmpty && taksitNumberError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            taksitNumberError = (double.tryParse(text) ?? -1) < 1 ? "" : null;
            setState(() {});
          },
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
          controller: paidTaksitController,
          suffixIcon: paidTaksitController.text.isNotEmpty && paidTaksitError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            paidTaksitError = (double.tryParse(text) ?? -1) < 1 ? "" : null;
            setState(() {});
          },
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
          controller: descriptionController,
          suffixIcon: descriptionController.text.isNotEmpty && descriptionError != null
              ? customTooltip(message: "Geçerli Bir Başlık Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            descriptionError = text.alphanumericValidation() ? null : "";
            setState(() {});
          },
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
                  isEdited: borrow != null,
                  enabled: ((double.tryParse(monthlyPriceController.text) ?? -1) > 1) &&
                      ((double.tryParse(totalBorrowController.text) ?? -1) > 1) &&
                      ((double.tryParse(payDayController.text) ?? -1) > 0) &&
                      ((double.tryParse(payDayController.text) ?? -1) < 32) &&
                      (double.tryParse(taksitNumberController.text) ?? -1) > 1 &&
                      (double.tryParse(paidTaksitController.text) ?? -1) > 1 &&
                      descriptionController.text.alphanumericValidation(),
                  onClear: () async {
                    LoadingUtils.instance.loading(true);

                    DTOBorrow request = DTOBorrow(
                      id: borrow?.id,
                    );

                    bool response = await BorrowServices.deleteBorrow(request);

                    if (response) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
                    }

                    LoadingUtils.instance.loading(false);
                  },
                  onTap: () async {
                    LoadingUtils.instance.loading(true);

                    DTOBorrow request = DTOBorrow(
                      title: descriptionController.text,
                      id: borrow?.id,
                      last_paid_month: DateTime.now().month,
                      monthly_price: double.tryParse(monthlyPriceController.text),
                      paid_taksit: int.tryParse(paidTaksitController.text),
                      pay_day: int.tryParse(payDayController.text),
                      total_borrow: double.tryParse(totalBorrowController.text),
                      total_taksit_count: int.tryParse(taksitNumberController.text),
                    );

                    bool response;
                    if (borrow != null) {
                      response = await BorrowServices.editBorrow(request);
                    } else {
                      response = await BorrowServices.createBorrow(request);
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

Widget button(BuildContext context, {required Function() onTap, required bool isEdited, required Function() onClear, required bool enabled}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: customMaterialButton(
            context: context,
            onTap: onTap,
            enabled: enabled,
            isLoading: false,
            text: "Tamamla",
            height: 35,
          ),
        ),
        if (isEdited) const SizedBox(width: 4),
        if (isEdited)
          Expanded(
            child: customMaterialButton(
              context: context,
              onTap: onClear,
              isLoading: false,
              backgroundColor: CustomColors.DARK_ORANGE,
              child: const Icon(Icons.delete),
              height: 35,
            ),
          ),
      ],
    ),
  );
}
