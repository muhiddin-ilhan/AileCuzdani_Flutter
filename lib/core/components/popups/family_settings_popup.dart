// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/family/family_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/loading_utils.dart';
import '../custom_tooltip.dart';

Future<bool?> showFamilySettingsPopup(BuildContext context) {
  TextEditingController controllerFamilyName = TextEditingController(
    text: Provider.of<AuthenticationProvider>(context, listen: false).user!.family!.title!,
  );
  TextEditingController controllerPerMonth = TextEditingController(
    text: Provider.of<AuthenticationProvider>(context, listen: false).user!.family!.period_day!.toString(),
  );

  String? errorFamilyName = controllerFamilyName.text.alphabeticValidation() ? null : "";
  String? errorPerMonth = int.tryParse(controllerPerMonth.text) != null
      ? (int.tryParse(controllerPerMonth.text)! > 0 && int.tryParse(controllerPerMonth.text)! < 29)
          ? null
          : ""
      : "";

  bool isReady = false;
  bool isLoading = false;

  setLoading(bool val, Function(void Function()) setState) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
    setState(() {});
  }

  return showDialog<bool>(
    context: context,
    barrierDismissible: !isLoading,
    builder: (_) => StatefulBuilder(builder: (_, setState) {
      isReady = errorFamilyName == null && errorPerMonth == null;
      return WillPopScope(
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
                    "Aile Ayarları",
                    style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: CustomColors.WHITE,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
                child: Text(
                  "Aile Adı",
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
                  hintText: "Aile Adı",
                  fontSize: 13,
                  prefixIcon: const Icon(Icons.family_restroom),
                  textInputAction: TextInputAction.next,
                  maxLength: 40,
                  height: 40,
                  controller: controllerFamilyName,
                  suffixIcon: controllerFamilyName.text.isNotEmpty && errorFamilyName != null
                      ? customTooltip(
                          message: "Geçerli Bir Aile Adı Giriniz Lütfen, En fazla 30 karakter",
                          child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                      : null,
                  onChanged: (text) {
                    errorFamilyName = text.alphabeticValidation() ? null : "";
                    setState(() {});
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
                child: Text(
                  "Ay Başı Günü",
                  style: TextStyle(
                    fontFamily: "JosefinSans",
                    color: Color.fromARGB(255, 81, 81, 81),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 6),
                child: customTextbox(
                  context,
                  borderRadius: 8,
                  enabled: !isLoading,
                  hintText: "Ay Başı Günü",
                  fontSize: 13,
                  prefixIcon: const Icon(Icons.restore),
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  maxLength: 2,
                  isNumber: true,
                  height: 40,
                  controller: controllerPerMonth,
                  suffixIcon: controllerPerMonth.text.isNotEmpty && errorPerMonth != null
                      ? customTooltip(
                          message: "Lütfen Geçerli Bir Ay Başı Günü Yazınız. 1 ila 28 Arasında Olacak Şekilde",
                          child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                      : null,
                  onChanged: (text) {
                    if (int.tryParse(text) != null) {
                      if (int.tryParse(text)! > 0 && int.tryParse(text)! < 29) {
                        errorPerMonth = null;
                        setState(() {});
                        return;
                      }
                    }
                    errorPerMonth = "";
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: customMaterialButton(
                        context: context,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        isLoading: isLoading,
                        enableLoadingAnim: false,
                        text: "Vazgeç",
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: customMaterialButton(
                        context: context,
                        onTap: isReady
                            ? () async {
                                setLoading(true, setState);

                                bool response = await FamilyServices.editFamilySetting(
                                  familyName: controllerFamilyName.text,
                                  periodDay: int.tryParse(controllerPerMonth.text)!,
                                );

                                if (response) {
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context, true);
                                  }
                                }

                                setLoading(false, setState);
                              }
                            : null,
                        isLoading: isLoading,
                        text: "Güncelle",
                        height: 40,
                        disableBackgroundColor: CustomColors.DARK_ORANGE,
                        backgroundColor: CustomColors.ORANGE,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}
