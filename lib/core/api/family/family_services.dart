// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/extensions/response_extension.dart';
import 'package:aile_cuzdani/core/model/dto_family.dart';
import 'package:aile_cuzdani/core/model/dto_family_request.dart';
import 'package:aile_cuzdani/core/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_snack_bar.dart';
import '../../model/dto_response.dart';
import '../../utils/loading_utils.dart';
import '../api.dart';

class FamilyServices {
  static Future<List<DTOFamily>?> getAllFamily() async {
    DTOResponse? response = await Api.instance!.get(
      endPoint: "family/get_all_families",
      responseModel: DTOResponse(),
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    return response.convertModel<DTOFamily>(context, model: DTOFamily());
  }

  static Future<DTOFamily?> getFamilyAndUsers() async {
    DTOResponse? response = await Api.instance!.get(
      endPoint: "family/get_family",
      responseModel: DTOResponse(),
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    return response.convertModel<DTOFamily>(context, model: DTOFamily());
  }

  static Future<bool> removeUserFromFamily({required String userId, required String familyId}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "family/remove_user_from_family",
      responseModel: DTOResponse(),
      body: {"user_id": userId, "family_id": familyId},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Aileden Çıkartma Başarıyla Gerçekleştirildi");
    return true;
  }

  static Future<bool> sendFamilyRequest({required String familyId}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "family/send_family_request",
      responseModel: DTOResponse(),
      body: {"family_id": familyId},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Aile Katılım Talebi Başarıyla Gönderildi");
    return true;
  }

  static Future<List<DTOFamilyRequest>?> getFamilyRequest({required bool isMine}) async {
    DTOResponse? response = await Api.instance!.get(
      endPoint: "family/get_family_request",
      responseModel: DTOResponse(),
      params: {"is_mine": isMine.toString()},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    return response.convertModel<DTOFamilyRequest>(context, model: DTOFamilyRequest());
  }

  static Future<bool> cancelFamilyRequest({required String familyId}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "family/cancel_family_request",
      responseModel: DTOResponse(),
      body: {"family_id": familyId},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Aile Katılım Talebi Başarıyla İptal Edildi");
    return true;
  }

  static Future<bool> createFamily({required String title}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "family/create_family",
      responseModel: DTOResponse(),
      body: {"title": title},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Aile Başarıyla Oluşturuldu");
    return true;
  }

  static Future<bool> answerFamilyRequest({required String requestId, required bool isAccept}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "family/answer_family_request",
      responseModel: DTOResponse(),
      body: {
        "family_request_id": requestId,
        "answer_state": isAccept ? 1 : -1,
      },
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Aile Katılım Talebi Başarıyla ${isAccept ? 'Onaylandı' : 'Reddedildi'}");
    return true;
  }

  static Future<bool> editFamilySetting({required String familyName, required int periodDay}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "family/edit_family_settings",
      responseModel: DTOResponse(),
      body: {
        "family_name": familyName,
        "period_day": periodDay,
      },
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    await Provider.of<AuthenticationProvider>(context, listen: false).getCurrentUser(context);

    customSnackBar(context, message: response!.message ?? "Aile Güncelleme İşlemi Başarıyla Gerçekleşti");
    return true;
  }
}
