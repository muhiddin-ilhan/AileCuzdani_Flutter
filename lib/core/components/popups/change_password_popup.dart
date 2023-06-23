// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:flutter/material.dart';
import '../../api/user/user_services.dart';
import '../../utils/loading_utils.dart';
import '../custom_tooltip.dart';

Future<bool?> showChangePasswordPopup(BuildContext context) {
  TextEditingController controllerOldPassword = TextEditingController();
  TextEditingController controllerNewPassword = TextEditingController();
  TextEditingController controllerNewPassword2 = TextEditingController();

  String? errorOldPassword = "";
  String? errorNewPassword = "";
  String? errorNewPassword2 = "";

  bool oldPasswordShow = true;
  bool newPasswordShow = true;
  bool newPassword2Show = true;

  bool isReady = false;
  bool isLoading = false;

  setLoading(bool val, Function(void Function()) setState) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
    setState(() {});
  }

  passwordShowIcon(int index, Function(void Function()) setState) {
    if (index == 0) {
      oldPasswordShow = !oldPasswordShow;
    } else if (index == 1) {
      newPasswordShow = !newPasswordShow;
    } else {
      newPassword2Show = !newPassword2Show;
    }
    setState(() {});
  }

  return showDialog<bool>(
    context: context,
    barrierDismissible: !isLoading,
    builder: (_) => StatefulBuilder(builder: (_, setState) {
      isReady = errorOldPassword == null && errorNewPassword == null && errorNewPassword2 == null;
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
                    "Şifre Değiştir",
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
                padding: const EdgeInsets.only(left: 12, bottom: 10, right: 12, top: 12),
                child: customTextbox(
                  context,
                  borderRadius: 8,
                  enabled: !isLoading,
                  hintText: "Eski Şifre",
                  fontSize: 13,
                  prefixIcon: const Icon(Icons.vpn_key),
                  textInputAction: TextInputAction.done,
                  maxLength: 18,
                  height: 40,
                  obsecureText: oldPasswordShow,
                  controller: controllerOldPassword,
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          passwordShowIcon(0, setState);
                        },
                        icon: Icon(oldPasswordShow ? Icons.visibility_off : Icons.visibility),
                      ),
                      if (controllerOldPassword.text.isNotEmpty && errorOldPassword != null)
                        customTooltip(
                          message: "Şifreniz en az 8 karakter olmalıdır",
                          child: const IconButton(
                            icon: Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                            onPressed: null,
                          ),
                        ),
                      const SizedBox(width: 6),
                    ],
                  ),
                  onChanged: (text) {
                    errorOldPassword = text.passwordValidation() ? null : "";
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 10, right: 12, top: 0),
                child: customTextbox(
                  context,
                  borderRadius: 8,
                  enabled: !isLoading,
                  hintText: "Yeni Şifre",
                  fontSize: 13,
                  prefixIcon: const Icon(Icons.key),
                  textInputAction: TextInputAction.done,
                  maxLength: 18,
                  height: 40,
                  obsecureText: newPasswordShow,
                  controller: controllerNewPassword,
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          passwordShowIcon(1, setState);
                        },
                        icon: Icon(newPasswordShow ? Icons.visibility_off : Icons.visibility),
                      ),
                      if (controllerNewPassword.text.isNotEmpty && errorNewPassword != null)
                        customTooltip(
                          message: "Şifreniz en az 8 karakter olmalıdır",
                          child: const IconButton(
                            icon: Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                            onPressed: null,
                          ),
                        ),
                      const SizedBox(width: 6),
                    ],
                  ),
                  onChanged: (text) {
                    errorNewPassword = text.passwordValidation() ? null : "";
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 0, right: 12, top: 0),
                child: customTextbox(
                  context,
                  borderRadius: 8,
                  enabled: !isLoading,
                  hintText: "Yeni Şifre (Tekrar)",
                  fontSize: 13,
                  prefixIcon: const Icon(Icons.key),
                  textInputAction: TextInputAction.done,
                  maxLength: 18,
                  height: 40,
                  obsecureText: newPassword2Show,
                  controller: controllerNewPassword2,
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          passwordShowIcon(2, setState);
                        },
                        icon: Icon(newPassword2Show ? Icons.visibility_off : Icons.visibility),
                      ),
                      if (controllerNewPassword2.text.isNotEmpty && errorNewPassword2 != null)
                        customTooltip(
                          message: "Şifreleriniz Eşleşmiyor, Lütfen Aynı Şifreyi Giriniz",
                          child: const IconButton(
                            icon: Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN),
                            onPressed: null,
                          ),
                        ),
                      const SizedBox(width: 6),
                    ],
                  ),
                  onChanged: (text) {
                    errorNewPassword2 = text == controllerNewPassword.text ? null : "";
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

                                Map<String, dynamic> request = {
                                  "old_password": controllerOldPassword.text,
                                  "password": controllerNewPassword.text,
                                  "password_check": controllerNewPassword2.text,
                                };

                                bool response = await UserServices.changePassword(request: request);

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
