// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/user/user_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/core/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/loading_utils.dart';
import '../custom_tooltip.dart';

Future<bool?> showUserEditPopup(BuildContext context, {required String whatEdit, required DTOUser user}) {
  TextEditingController controller1 = TextEditingController(text: user.name ?? (user.email ?? (user.phone_number)));
  TextEditingController controller2 = TextEditingController(text: user.surname);

  String? error1 = user.name != null
      ? (user.name!.alphabeticValidation() ? null : "")
      : user.email != null
          ? (user.email!.emailValidation() ? null : "")
          : user.phone_number != null
              ? (user.phone_number!.phoneNumberValidation() ? null : "")
              : null;
  String? error2 = user.surname != null ? (user.surname!.alphabeticValidation() ? null : "") : null;

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
      isReady = error1 == null && error2 == null;
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
                    "Kullanıcı Güncelle",
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
                padding: const EdgeInsets.only(left: 12, bottom: 10, right: 12, top: 10),
                child: customTextbox(
                  context,
                  borderRadius: 8,
                  enabled: !isLoading,
                  hintText: whatEdit == "ADSOYAD"
                      ? "Adınız"
                      : whatEdit == "EMAIL"
                          ? "Email Adresiniz"
                          : whatEdit == "PHONENUMBER"
                              ? "Telefon Numaranız"
                              : "",
                  fontSize: 13,
                  isCapitalizeSentence: whatEdit == "ADSOYAD" ? true : false,
                  prefixIcon: const Icon(Icons.group_add),
                  textInputAction: TextInputAction.done,
                  maxLength: whatEdit == "ADSOYAD"
                      ? 30
                      : whatEdit == "EMAIL"
                          ? 50
                          : 11,
                  height: 40,
                  controller: controller1,
                  suffixIcon: controller1.text.isNotEmpty && error1 != null
                      ? customTooltip(
                          message: whatEdit == "ADSOYAD"
                              ? "Lütfen Geçerli Bir İsim Giriniz"
                              : whatEdit == "EMAIL"
                                  ? "Lütfen Geçerli Bir Email Giriniz"
                                  : whatEdit == "PHONENUMBER"
                                      ? "Lütfen 11 Haneli Telefon Numarası Giriniz"
                                      : "",
                          child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                      : null,
                  onChanged: (text) {
                    if (whatEdit == "ADSOYAD") {
                      error1 = text.alphabeticValidation() ? null : "";
                    } else if (whatEdit == "EMAIL") {
                      error1 = text.emailValidation() ? null : "";
                    } else if (whatEdit == "PHONENUMBER") {
                      error1 = text.phoneNumberValidation() ? null : "";
                    }

                    setState(() {});
                  },
                ),
              ),
              if (whatEdit == "ADSOYAD")
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 0, right: 12, top: 0),
                  child: customTextbox(
                    context,
                    borderRadius: 8,
                    enabled: !isLoading,
                    hintText: whatEdit == "ADSOYAD" ? "Soyadınız" : "",
                    fontSize: 13,
                    prefixIcon: const Icon(Icons.group_add),
                    textInputAction: TextInputAction.done,
                    maxLength: 30,
                    height: 40,
                    isCapitalizeSentence: whatEdit == "ADSOYAD" ? true : false,
                    controller: controller2,
                    suffixIcon: controller2.text.isNotEmpty && error2 != null
                        ? customTooltip(message: "Geçerli Bir Soyadı Giriniz Lütfen", child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                        : null,
                    onChanged: (text) {
                      error2 = text.alphabeticValidation() ? null : "";
                      setState(() {});
                    },
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

                                DTOUser request = DTOUser(
                                  name: whatEdit == "ADSOYAD" ? controller1.text : null,
                                  surname: whatEdit == "ADSOYAD" ? controller2.text : null,
                                  email: whatEdit == "EMAIL" ? controller1.text : null,
                                  phone_number: whatEdit == "PHONENUMBER" ? controller1.text : null,
                                );

                                bool response = await UserServices.editCurrentUser(request: request);

                                if (response) {
                                  await Provider.of<AuthenticationProvider>(context, listen: false).getCurrentUser(context);
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
