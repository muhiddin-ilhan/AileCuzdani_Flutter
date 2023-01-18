// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:aile_cuzdani/core/api/user/user_services.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/notification_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/loading_utils.dart';

Future<bool?> showNotificationSettingsPopup(BuildContext context) async {
  bool loading = false;
  bool error = false;

  setLoading(bool val, Function(void Function()) setState) {
    loading = val;
    LoadingUtils.instance.loading(val);
    setState(() {});
  }

  Provider.of<NotificationSettingsProvider>(context, listen: false).getSharedInfos();

  return showDialog<bool?>(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      error = false;
      return Consumer<NotificationSettingsProvider>(builder: (_, provider, __) {
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
                    child: SwitchListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      tileColor: Colors.white,
                      value: provider.transaction_update ?? true,
                      activeColor: CustomColors.GREEN,
                      dense: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      title: const Text(
                        "İşlem Güncelleme",
                        style: TextStyle(
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        provider.setTransactionUpdateSetting(value);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
                    child: SwitchListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      tileColor: Colors.white,
                      value: provider.transaction_add_delete ?? true,
                      activeColor: CustomColors.GREEN,
                      dense: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      title: const Text(
                        "İşlem Ekle/Sil",
                        style: TextStyle(
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        provider.setTransactionAddDeleteSetting(value);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
                    child: SwitchListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      tileColor: Colors.white,
                      value: provider.family_request ?? true,
                      activeColor: CustomColors.GREEN,
                      dense: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      title: const Text(
                        "Aile Katılım İstekleri",
                        style: TextStyle(
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        provider.setFamilyRequestSetting(value);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
                    child: SwitchListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      tileColor: Colors.white,
                      value: provider.family_leaving ?? true,
                      activeColor: CustomColors.GREEN,
                      dense: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      title: const Text(
                        "Aile Ayrılışları",
                        style: TextStyle(
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        provider.setFamilyLeavingSetting(value);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
                    child: SwitchListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      tileColor: Colors.white,
                      value: provider.family_updates ?? true,
                      activeColor: CustomColors.GREEN,
                      dense: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      title: const Text(
                        "Aile Güncellemeleri",
                        style: TextStyle(
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        provider.setFamilyUpdatesSetting(value);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
                    child: SwitchListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      tileColor: Colors.white,
                      value: provider.card_add_delete ?? true,
                      activeColor: CustomColors.GREEN,
                      dense: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      title: const Text(
                        "Kart Ekle/Sil",
                        style: TextStyle(
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        provider.setCardAddDeleteSetting(value);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
                    child: SwitchListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      tileColor: Colors.white,
                      value: provider.transfer_between_cards ?? true,
                      activeColor: CustomColors.GREEN,
                      dense: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      title: const Text(
                        "Kartlar Arası Transfer",
                        style: TextStyle(
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        provider.setTransferBetweenCardsSetting(value);
                        setState(() {});
                      },
                    ),
                  ),
                  button(
                    context,
                    loading: loading,
                    error: error,
                    onTap: () async {
                      setLoading(true, setState);
                      try {
                        await UserServices.saveTokenToDatabase();
                      } catch (e) {
                        log(e.toString());
                      }

                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }

                      setLoading(false, setState);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });
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
        "Bildirim Ayarları",
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

Padding button(
  BuildContext context, {
  required Function() onTap,
  required bool loading,
  required bool error,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: customMaterialButton(
      context: context,
      onTap: onTap,
      isLoading: loading,
      text: "Kaydet",
      height: 40,
      enabled: !error,
    ),
  );
}
