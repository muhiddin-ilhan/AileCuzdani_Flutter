// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/components/custom_tooltip.dart';
import 'package:aile_cuzdani/core/components/dropdowns/bucket_dropdown.dart';
import 'package:aile_cuzdani/core/components/dropdowns/currency_dropdown.dart';
import 'package:aile_cuzdani/core/components/dropdowns/currency_platform_dropdown.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<bool?> showAddCurrencyPopup(BuildContext context) async {
  String? selectedCurrencyType;
  String? selectedPlatform;
  DTOBucket? selectedBankAccount;
  TextEditingController currencyCountController = TextEditingController();
  TextEditingController currencyValueController = TextEditingController();

  String? currencyCountError = "";
  String? currencyValueError = "";

  Provider.of<BucketProvider>(context, listen: false).getBuckets(context);
  Provider.of<BucketProvider>(context, listen: false).getCreditCards(context);

  List<Widget> getCurrencyTypeDropdownArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Döviz Türü",
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
        child: currencyDropdown(
          context,
          onSelected: (String? currencyType) {
            selectedCurrencyType = currencyType;
            setState(() {});
          },
          value: selectedCurrencyType,
        ),
      ),
    ];
  }

  List<Widget> getCurrencyCountArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Döviz Miktarı",
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
          inputType: TextInputType.number,
          controller: currencyCountController,
          suffixIcon: currencyCountController.text.isNotEmpty && currencyCountError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            double val = double.tryParse(text) ?? -1;
            currencyCountError = val < 0 ? "" : null;
            setState(() {});
          },
          maxLength: 8,
        ),
      ),
    ];
  }

  List<Widget> getCurrencyValueArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Döviz Fiyatı",
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
          maxLength: 8,
          inputType: TextInputType.number,
          controller: currencyValueController,
          suffixIcon: currencyValueController.text.isNotEmpty && currencyValueError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            double val = double.tryParse(text) ?? -1;
            currencyValueError = val < 0 ? "" : null;
            setState(() {});
          },
        ),
      ),
    ];
  }

  List<Widget> getPlatformDropdownArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Platform",
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
        child: currencyPlatformDropdown(
          context,
          isDolar: selectedCurrencyType == "Dolar",
          onSelected: (String? platform) {
            selectedPlatform = platform;
            setState(() {});
          },
          value: selectedPlatform,
        ),
      ),
    ];
  }

  List<Widget> getBankAccountArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Çekilecek Hesap",
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
            items: providerBucket.buckets + providerBucket.creditCards,
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
                ...getCurrencyTypeDropdownArea(setState),
                ...getCurrencyCountArea(setState),
                ...getCurrencyValueArea(setState),
                ...getBankAccountArea(setState),
                ...getPlatformDropdownArea(setState),
                button(
                  context,
                  enabled: selectedBankAccount != null &&
                      selectedCurrencyType != null &&
                      selectedPlatform != null &&
                      (double.tryParse(currencyCountController.text) ?? -1) > 0 &&
                      (double.tryParse(currencyValueController.text) ?? -1) > 0,
                  onClear: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context, true);
                    }
                  },
                  onTap: () async {
                    LoadingUtils.instance.loading(true);

                    DTOBucket request = DTOBucket(
                      title: selectedCurrencyType,
                      currency_type: selectedCurrencyType,
                      count: double.tryParse(currencyCountController.text) ?? 0,
                      money: (double.tryParse(currencyValueController.text) ?? 0) * -1,
                      platform: selectedPlatform,
                      cekilecek_hesap_id: selectedBankAccount!.id,
                      show_my_assets: 1,
                      type: 3,
                    );

                    bool response = await BucketServices.createBucket(request);

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
        "Döviz Ekle",
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
