// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/components/custom_tooltip.dart';
import 'package:aile_cuzdani/core/components/dropdowns/bucket_dropdown.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<bool?> showRemoveCryptoPopup(BuildContext context, {DTOBucket? bucket}) async {
  bool isShowMyAssets = true;
  DTOBucket? selectedBankAccount;

  TextEditingController cryptoCountController = TextEditingController();
  TextEditingController cryptoValueController = TextEditingController();

  String? cryptoCountError = "";
  String? cryptoValueError = "";

  Provider.of<BucketProvider>(context, listen: false).getBuckets(context);

  if (bucket != null) {
    cryptoCountController.text = (bucket.count ?? 0).toString();

    isShowMyAssets = bucket.show_my_assets == 1;

    cryptoCountError = (double.tryParse(cryptoCountController.text) ?? -1) < 0 ? "" : null;
  }

  List<Widget> getCoinCountArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Coin Adeti",
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
          inputType: TextInputType.number,
          controller: cryptoCountController,
          suffixIcon: cryptoCountController.text.isNotEmpty && cryptoCountError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            double val = double.tryParse(text) ?? -1;
            cryptoCountError = val < 0 ? "" : null;
            setState(() {});
          },
          minWidthPrefix: 40,
          maxLength: 8,
        ),
      ),
    ];
  }

  List<Widget> getCoinValueArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Coin Değeri",
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
          controller: cryptoValueController,
          suffixIcon: cryptoValueController.text.isNotEmpty && cryptoValueError != null
              ? customTooltip(message: "Geçerli Bir Miktar Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
              : null,
          onChanged: (text) {
            double val = double.tryParse(text) ?? -1;
            cryptoValueError = val < 0 ? "" : null;
            setState(() {});
          },
          maxLength: 8,
        ),
      ),
    ];
  }

  List<Widget> getPlatformDropdownArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Aktarılacak Hesap",
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
            onChanged: (val) async {
              isShowMyAssets = val;
              LoadingUtils.instance.loading(true);

              bucket!.show_my_assets = val ? 1 : 0;

              bool response = await BucketServices.editBucket(bucket);

              if (response) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context, true);
                }
              }

              LoadingUtils.instance.loading(false);
              setState(() {});
            },
          )
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
                ...getCoinCountArea(setState),
                ...getCoinValueArea(setState),
                ...getPlatformDropdownArea(setState),
                showMyAssetsToggle(setState),
                button(
                  context,
                  enabled: selectedBankAccount != null &&
                      (double.tryParse(cryptoCountController.text) ?? -1) > 0 &&
                      (double.tryParse(cryptoValueController.text) ?? -1) > 0,
                  onClear: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context, true);
                    }
                  },
                  onTap: () async {
                    LoadingUtils.instance.loading(true);

                    bool response = await BucketServices.transferBetweenBucket(
                      money: double.tryParse(cryptoValueController.text) ?? 0.0,
                      recieverBucketId: selectedBankAccount!.id!,
                      senderBucketId: bucket!.id!,
                      count: double.tryParse(cryptoCountController.text) ?? 0.0,
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
        "Coin Bozdur",
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
