// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/components/custom_tooltip.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';

Future<bool?> showAddCardPopup(BuildContext context, {DTOBucket? bucket}) async {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerKurus = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();

  String? errorTitle = "";

  bool loading = false;
  bool isReady = false;

  if (bucket != null) {
    controller.text = (bucket.money ?? 0.0).toString().split(".")[0];
    controllerKurus.text = (bucket.money ?? 0.0).toStringAsFixed(2).split(".")[1];
    controllerTitle.text = bucket.title ?? "";

    errorTitle = controllerTitle.text.alphanumericValidation() ? null : "";
  }

  setLoading(bool val, Function(void Function()) setState) {
    loading = val;
    LoadingUtils.instance.loading(val);
    setState(() {});
  }

  return showDialog<bool?>(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      isReady = errorTitle == null;
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
              children: [
                appBar(bucket),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: customTextbox(
                    context,
                    borderRadius: 8,
                    fontSize: 14,
                    height: 45,
                    enabled: !loading,
                    inputType: TextInputType.text,
                    hintText: "Kart Adı",
                    isCapitalizeSentence: true,
                    controller: controllerTitle,
                    prefixIcon: const Icon(Icons.description),
                    textInputAction: TextInputAction.done,
                    suffixIcon: controllerTitle.text.isNotEmpty && errorTitle != null
                        ? customTooltip(message: "Geçerli bir ad giriniz lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                        : null,
                    maxLength: 30,
                    onChanged: (text) {
                      errorTitle = text.alphanumericValidation() ? null : "";
                      setState(() {});
                    },
                  ),
                ),
                priceTextbox(
                  context,
                  controller,
                  controllerKurus,
                  (text) {
                    setState(() {});
                  },
                  loading,
                ),
                button(
                  context,
                  isReady: isReady,
                  loading: loading,
                  bucket: bucket,
                  onDelete: () async {
                    setLoading(true, setState);

                    DTOBucket request = DTOBucket(
                      id: bucket?.id,
                    );

                    bool response = await BucketServices.deleteBucket(request);

                    if (response) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
                    }

                    setLoading(false, setState);
                  },
                  onTap: () async {
                    setLoading(true, setState);

                    DTOBucket request = DTOBucket(
                      id: bucket?.id,
                      title: controllerTitle.text,
                      money: double.tryParse("${controller.text}.${controllerKurus.text}") ?? 0,
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

                    setLoading(false, setState);
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

Container appBar(DTOBucket? bucket) {
  return Container(
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
        bucket != null ? 'Güncelle' : 'Kart Ekle',
        style: const TextStyle(
          fontFamily: "JosefinSans",
          color: CustomColors.WHITE,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Padding button(
  BuildContext context, {
  required bool isReady,
  required Function() onTap,
  required Function() onDelete,
  required bool loading,
  DTOBucket? bucket,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Expanded(
          child: customMaterialButton(
            context: context,
            onTap: isReady ? onTap : null,
            isLoading: loading,
            text: "Tamam",
            height: 40,
          ),
        ),
        if (bucket != null) const SizedBox(width: 6),
        if (bucket != null)
          customMaterialButton(
            context: context,
            onTap: isReady ? onDelete : null,
            isLoading: loading,
            enableLoadingAnim: false,
            child: const Icon(Icons.delete_outline, color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 148, 54, 54),
            height: 40,
          ),
      ],
    ),
  );
}

Padding priceTextbox(BuildContext context, TextEditingController controller, TextEditingController controllerKurus, Function(String)? onChanged, bool loading) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: customTextbox(
            context,
            borderRadius: 8,
            enabled: !loading,
            contentPaddingEdge: const EdgeInsets.only(right: 8),
            textAlign: TextAlign.end,
            fontSize: 14,
            height: 45,
            controller: controller,
            hintText: "0",
            inputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 9,
            prefixIcon: const Icon(Icons.currency_lira_outlined),
            onChanged: onChanged,
            isNumber: true,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            ",",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: CustomColors.VERY_DARK_GREEN,
            ),
          ),
        ),
        Expanded(
          child: customTextbox(
            context,
            borderRadius: 8,
            fontSize: 14,
            height: 45,
            enabled: !loading,
            controller: controllerKurus,
            contentPaddingEdge: const EdgeInsets.only(left: 8),
            hintText: "00",
            inputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLength: 2,
            isNumber: true,
            isMinusNumber: false,
          ),
        ),
      ],
    ),
  );
}
