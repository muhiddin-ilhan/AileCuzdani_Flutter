// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/extensions/response_extension.dart';
import 'package:aile_cuzdani/core/model/dto_create_transaction_request.dart';
import 'package:aile_cuzdani/core/model/dto_transaction.dart';
import 'package:aile_cuzdani/core/model/dto_transaction_request.dart';
import 'package:flutter/material.dart';

import '../../components/custom_snack_bar.dart';
import '../../model/dto_response.dart';
import '../../utils/loading_utils.dart';
import '../api.dart';

class TransactionService {
  static Future<DTOResponse?> getHomeTransaction() async {
    DTOResponse? response = await Api.instance!.get(
      endPoint: "transaction/get_home_transactions",
      responseModel: DTOResponse(),
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    if (!response.isHasTotalValues(context)) return null;

    response!.data = response.convertModel<DTOTransaction>(context, model: DTOTransaction()) as List<DTOTransaction>;

    return response.data != null ? response : null;
  }

  static Future<DTOResponse?> getTransactions({required DTOTransactionRequest request}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "transaction/get_transactions",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    if (!response.isHasTotalValues(context)) return null;

    response!.data = response.convertModel<DTOTransaction>(context, model: DTOTransaction()) as List<DTOTransaction>;

    return response.data != null ? response : null;
  }

  static Future<bool> createTransactions({required DTOCreateTransactionRequest request}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "transaction/create_transaction",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "İşlem Başarılı");
    return true;
  }

  static Future<bool> updateTransactions({required DTOCreateTransactionRequest request}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "transaction/update_transaction",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "İşlem Başarıyla Güncellendi");
    return true;
  }

  static Future<bool> deleteTransactions({required String transactionId}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "transaction/delete_transaction",
      responseModel: DTOResponse(),
      body: {"transaction_id": transactionId},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "İşlem Başarıyla Silindi");
    return true;
  }
}
