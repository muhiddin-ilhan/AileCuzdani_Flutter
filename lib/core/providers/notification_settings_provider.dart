// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:aile_cuzdani/core/model/dto_fcm_token_request.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/core/utils/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationSettingsProvider extends ChangeNotifier {
  bool? transaction_update;
  bool? transaction_add_delete;
  bool? family_request;
  bool? family_leaving;
  bool? family_updates;
  bool? card_add_delete;
  bool? transfer_between_cards;

  Future<DTOFcmTokenRequest?> getRequest() async {
    try {
      transaction_update = await SharedManager.instance.getBoolValue("transaction_update") ?? true;
      transaction_add_delete = await SharedManager.instance.getBoolValue("transaction_add_delete") ?? true;
      family_request = await SharedManager.instance.getBoolValue("family_request") ?? true;
      family_leaving = await SharedManager.instance.getBoolValue("family_leaving") ?? true;
      family_updates = await SharedManager.instance.getBoolValue("family_updates") ?? true;
      card_add_delete = await SharedManager.instance.getBoolValue("card_add_delete") ?? true;
      transfer_between_cards = await SharedManager.instance.getBoolValue("transfer_between_cards") ?? true;

      String? token = await FirebaseMessaging.instance.getToken();

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String? deviceId;
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = '${androidInfo.model}:${androidInfo.id}';
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = '${iosInfo.name}:${iosInfo.identifierForVendor}';
      }

      return DTOFcmTokenRequest(
        fcm_token: token,
        device_id: deviceId,
        card_add_delete: card_add_delete,
        family_leaving: family_leaving,
        family_request: family_request,
        family_updates: family_updates,
        transaction_add_delete: transaction_add_delete,
        transaction_update: transaction_update,
        transfer_between_cards: transfer_between_cards,
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future getSharedInfos() async {
    try {
      LoadingUtils.instance.loading(true);

      transaction_update = await SharedManager.instance.getBoolValue("transaction_update") ?? true;
      transaction_add_delete = await SharedManager.instance.getBoolValue("transaction_add_delete") ?? true;
      family_request = await SharedManager.instance.getBoolValue("family_request") ?? true;
      family_leaving = await SharedManager.instance.getBoolValue("family_leaving") ?? true;
      family_updates = await SharedManager.instance.getBoolValue("family_updates") ?? true;
      card_add_delete = await SharedManager.instance.getBoolValue("card_add_delete") ?? true;
      transfer_between_cards = await SharedManager.instance.getBoolValue("transfer_between_cards") ?? true;

      LoadingUtils.instance.loading(false);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> setTransactionUpdateSetting(bool value) async {
    try {
      LoadingUtils.instance.loading(true);
      await SharedManager.instance.setBoolValue("transaction_update", value);
      transaction_update = value;
      notifyListeners();
      LoadingUtils.instance.loading(false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setTransactionAddDeleteSetting(bool value) async {
    try {
      LoadingUtils.instance.loading(true);
      await SharedManager.instance.setBoolValue("transaction_add_delete", value);
      transaction_add_delete = value;
      notifyListeners();
      LoadingUtils.instance.loading(false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setFamilyRequestSetting(bool value) async {
    try {
      LoadingUtils.instance.loading(true);
      await SharedManager.instance.setBoolValue("family_request", value);
      family_request = value;
      notifyListeners();
      LoadingUtils.instance.loading(false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setFamilyLeavingSetting(bool value) async {
    try {
      LoadingUtils.instance.loading(true);
      await SharedManager.instance.setBoolValue("family_leaving", value);
      family_leaving = value;
      notifyListeners();
      LoadingUtils.instance.loading(false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setFamilyUpdatesSetting(bool value) async {
    try {
      LoadingUtils.instance.loading(true);
      await SharedManager.instance.setBoolValue("family_updates", value);
      family_updates = value;
      notifyListeners();
      LoadingUtils.instance.loading(false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setCardAddDeleteSetting(bool value) async {
    try {
      LoadingUtils.instance.loading(true);
      await SharedManager.instance.setBoolValue("card_add_delete", value);
      card_add_delete = value;
      notifyListeners();
      LoadingUtils.instance.loading(false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setTransferBetweenCardsSetting(bool value) async {
    try {
      LoadingUtils.instance.loading(true);
      await SharedManager.instance.setBoolValue("transfer_between_cards", value);
      transfer_between_cards = value;
      notifyListeners();
      LoadingUtils.instance.loading(false);
      return true;
    } catch (e) {
      return false;
    }
  }
}
