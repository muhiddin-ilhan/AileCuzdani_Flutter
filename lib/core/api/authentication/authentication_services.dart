// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:aile_cuzdani/core/components/custom_snack_bar.dart';
import 'package:aile_cuzdani/core/extensions/response_extension.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';

import '../../model/dto_response.dart';
import '../../utils/shared_preferences.dart';
import '../api.dart';

class AuthenticationServices {
  static Future<DTOUser?> login(DTOUser request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "auth/login",
      responseModel: DTOResponse(),
      body: request,
    );

    inspect(response);

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    if (response.isHasAccessToken(context)) {
      Api.instance!.setToken(response!.access_token!);
      await SharedManager.instance.setStringValue("token", response.access_token!);
    }

    return response.convertModel<DTOUser>(context, model: DTOUser());
  }

  static Future<DTOUser?> isAuthentication(DTOUser request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "auth/is_authentication",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true, onlyDataCheck: true)) return null;

    return response.convertModel<DTOUser>(context, model: DTOUser());
  }

  static Future<DTOUser?> register(DTOUser request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "auth/register",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    if (response.isHasAccessToken(context)) {
      Api.instance!.setToken(response!.access_token!);
    }

    return response.convertModel<DTOUser>(context, model: DTOUser());
  }

  static Future<bool> forgotPassword(DTOUser request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "auth/forgot_password",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Emailinize şifre sıfırlama kodu gönderilmiştir");
    return true;
  }

  static Future<bool> validateResetKey({required String resetKey}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "auth/validate_reset_key",
      responseModel: DTOResponse(),
      body: {"reset_token": resetKey},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Şifre sıfırlama kodunuz başarılı şekilde onaylanmıştır");
    return true;
  }

  static Future<bool> resetPassword({required String password, required String newPassword, required String resetToken}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "auth/reset_password",
      responseModel: DTOResponse(),
      body: {"new_password": password, "new_password_confirm": newPassword, "reset_token": resetToken},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Şifre sıfırlama işleminiz başarıyla gerçekleşti");
    return true;
  }
}
