// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:aile_cuzdani/core/extensions/response_extension.dart';
import 'package:aile_cuzdani/core/model/dto_borrow.dart';
import 'package:flutter/material.dart';

import '../../components/custom_snack_bar.dart';
import '../../model/dto_response.dart';
import '../../utils/loading_utils.dart';
import '../api.dart';

class BorrowServices {
  static Future<List<DTOBorrow>?> getAllBorrows() async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "borrow/get_all_borrows",
      body: {},
      responseModel: DTOResponse(),
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    return response.convertModel<DTOBorrow>(context, model: DTOBorrow());
  }

  static Future<bool> createBorrow(DTOBorrow request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "borrow/create_borrow",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Borç Başarıyla Oluşturuldu");
    return true;
  }

  static Future<bool> editBorrow(DTOBorrow request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "borrow/edit_borrow",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Borç Başarıyla Güncellendi");
    return true;
  }

  static Future<bool> deleteBorrow(DTOBorrow request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "borrow/delete_borrow",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Borç Başarıyla Silindi");
    return true;
  }

  static Future<bool> payBorrow({required String borrowId, required String cekilecekHesapId, required double money}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "borrow/pay_borrow",
      responseModel: DTOResponse(),
      body: {"_id": borrowId, "cekilecek_hesap_id": cekilecekHesapId, "odenen_miktar": money},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Ödeme İşlemi Başarıyla Gerçekleşti");
    return true;
  }
}
