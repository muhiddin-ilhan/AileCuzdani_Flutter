// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:aile_cuzdani/core/extensions/response_extension.dart';
import 'package:aile_cuzdani/core/model/dto_fcm_token_request.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/core/providers/authentication_provider.dart';
import 'package:aile_cuzdani/core/providers/notification_settings_provider.dart';
import 'package:aile_cuzdani/core/session/app_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_snack_bar.dart';
import '../../model/dto_response.dart';
import '../../utils/loading_utils.dart';
import '../api.dart';

class UserServices {
  static Future<DTOUser?> getCurrentUser(BuildContext context) async {
    DTOResponse? response = await Api.instance!.get(
      endPoint: "user/get_current_user",
      responseModel: DTOResponse(),
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    DTOUser? user = response.convertModel<DTOUser>(context, model: DTOUser());

    if (user != null) {
      Provider.of<AuthenticationProvider>(context, listen: false).setUser(user);
      AppSession.instance.setUser(user);
    }

    return user;
  }

  static Future<bool> editCurrentUser({required DTOUser request}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "user/edit_current_user",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Bilgi Başarıyla Güncellendi");
    return true;
  }

  static Future<bool> changePassword({required Map<String, dynamic> request}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "user/change_password",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Şifre Başarıyla Güncellendi");
    return true;
  }

  static Future<bool> saveTokenToDatabase({bool isDeleted = false}) async {
    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    DTOFcmTokenRequest? request = await Provider.of<NotificationSettingsProvider>(context, listen: false).getRequest();

    if (request == null) {
      customSnackBar(context, message: "Firebase Token Error");
      return false;
    }

    if (isDeleted) {
      request.fcm_token = null;
    }

    DTOResponse? response = await Api.instance!.post(
      endPoint: "user/save_fcm_token",
      responseModel: DTOResponse(),
      body: request,
    );

    if (!response.isSuccess(context)) return false;

    return true;
  }

  static Future<bool> sendEmail({required String? message, required String? content}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "user/send_email",
      responseModel: DTOResponse(),
      body: {"message_title": message, "message_content": content},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    return true;
  }

  static Future<bool> deleteAccount() async {
    DTOResponse? response = await Api.instance!.get(
      endPoint: "user/delete_account",
      responseModel: DTOResponse(),
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    exit(0);
  }
}
