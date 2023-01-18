// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/extensions/response_extension.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:flutter/material.dart';

import '../../components/custom_snack_bar.dart';
import '../../model/dto_response.dart';
import '../../utils/loading_utils.dart';
import '../api.dart';

class BucketServices {
  static Future<List<DTOBucket>?> getAllFamilyBucket() async {
    DTOResponse? response = await Api.instance!.get(
      endPoint: "bucket/get_all_family_buckets",
      responseModel: DTOResponse(),
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    return response.convertModel<DTOBucket>(context, model: DTOBucket());
  }

  static Future<bool> createBucket(DTOBucket request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "bucket/create_bucket",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Kart Başarıyla Oluşturuldu");
    return true;
  }

  static Future<bool> editBucket(DTOBucket request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "bucket/edit_bucket",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Kart Başarıyla Güncellendi");
    return true;
  }

  static Future<bool> deleteBucket(DTOBucket request) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "bucket/delete_bucket",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Kart Başarıyla Silindi");
    return true;
  }

  static Future<bool> transferBetweenBucket({required String senderBucketId, required String recieverBucketId, required double money}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "bucket/transfer_between_bucket",
      responseModel: DTOResponse(),
      body: {"sender_bucket_id": senderBucketId, "reciever_bucket_id": recieverBucketId, "price": money},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context)) return false;

    customSnackBar(context, message: response!.message ?? "Transfer İşlemi Başarıyla Gerçekleşti");
    return true;
  }
}
