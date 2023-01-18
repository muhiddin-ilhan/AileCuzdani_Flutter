// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/user/user_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';

import '../custom_tooltip.dart';

Future<bool?> showCommunicationPopup(BuildContext context) async {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerMessage = TextEditingController();

  String? errorTitle = "";
  String? errorMessage = "";

  bool isReady = false;
  bool isLoading = false;

  return showDialog<bool?>(
    context: context,
    builder: (_) => StatefulBuilder(builder: (_, setState) {
      isReady = errorTitle == null && errorMessage == null;
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
                  child: Text(
                    "Mesaj Başlığı",
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
                    enabled: !isLoading,
                    hintText: "Mesaj Başlığı",
                    fontSize: 13,
                    prefixIcon: const Icon(Icons.filter_tilt_shift_rounded),
                    textInputAction: TextInputAction.next,
                    maxLength: 40,
                    height: 40,
                    controller: controllerTitle,
                    suffixIcon: controllerTitle.text.isNotEmpty && errorTitle != null
                        ? customTooltip(
                            message: "Geçerli Bir Başlık Giriniz Lütfen, En fazla 30 karakter",
                            child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                        : null,
                    onChanged: (text) {
                      errorTitle = text.alphanumericValidation() ? null : "";
                      setState(() {});
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
                  child: Text(
                    "Mesaj İçeriği",
                    style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 81, 81, 81),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 10),
                  child: customTextbox(
                    context,
                    borderRadius: 8,
                    enabled: !isLoading,
                    fontSize: 13,
                    prefixIcon: const Icon(Icons.mail),
                    textInputAction: TextInputAction.done,
                    maxLength: 400,
                    height: 80,
                    isMultiline: true,
                    controller: controllerMessage,
                    contentPadding: 10,
                    textAlignVertical: TextAlignVertical.center,
                    suffixIcon: controllerMessage.text.isNotEmpty && errorMessage != null
                        ? customTooltip(message: "Mesaj Alanını Boş Bırakamazsınız", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                        : null,
                    onChanged: (text) {
                      errorMessage = text.length > 3 ? null : "";
                      setState(() {});
                    },
                  ),
                ),
                button(
                  context,
                  isReady: isReady,
                  loading: isLoading,
                  onTap: () async {
                    LoadingUtils.instance.loading(true);

                    bool response = await UserServices.sendEmail(message: controllerTitle.text, content: controllerMessage.text);

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
        "İletişime Geç",
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

Padding button(BuildContext context, {required Function() onTap, required bool loading, required bool isReady}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Expanded(
          child: customMaterialButton(
            context: context,
            onTap: onTap,
            enabled: isReady,
            isLoading: loading,
            text: "Gönder",
            height: 40,
          ),
        ),
      ],
    ),
  );
}
