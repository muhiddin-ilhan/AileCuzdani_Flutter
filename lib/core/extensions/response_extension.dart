import 'package:aile_cuzdani/core/base/base_model.dart';
import 'package:aile_cuzdani/core/model/dto_response.dart';
import 'package:flutter/material.dart';

import '../components/custom_snack_bar.dart';
import '../utils/navigate_utils.dart';

extension ResponseExtension on DTOResponse? {
  bool isSuccess(BuildContext context, {bool checkData = false, bool onlyDataCheck = false}) {
    if (this != null) {
      if (this!.success != null) {
        if (this!.success!) {
          if (checkData) {
            if (this!.data != null) {
              return true;
            }
          } else {
            return true;
          }
        }
      }
    }

    if (onlyDataCheck) {
      return false;
    }

    if (this != null) {
      if (this!.message == "UNAUTHORIZED") {
        NavigateUtils.logout(context);
        customSnackBar(context, message: "Oturum Süreniz Dolmuştur, Lütfen Tekrar Giriş Yapınız");
        return false;
      }

      if (this!.message == "Veri Bulunamadı") {
        return false;
      }

      customSnackBar(context, message: this!.message ?? "Bir Hata Meydana Geldi");
      return false;
    }

    customSnackBar(context, message: "Bir Hata Meydana Geldi");
    return false;
  }

  bool isHasAccessToken(BuildContext context) {
    if (this != null) {
      if (this!.success != null) {
        if (this!.success!) {
          if (this!.access_token != null) {
            return true;
          }
        }
      }
    }

    customSnackBar(context, message: "Bir Hata Meydana Geldi");
    return false;
  }

  bool isHasTotalValues(BuildContext context) {
    if (this != null) {
      if (this!.success != null) {
        if (this!.success!) {
          if (this!.data is List) {
            if ((this!.data as List).isEmpty) {
              return true;
            }
          }
          if (this!.totalValues != null) {
            return true;
          }
        }
      }
    }

    customSnackBar(context, message: "Bir Hata Meydana Geldi");
    return false;
  }

  dynamic convertModel<T extends BaseModel>(BuildContext context, {required T model}) {
    try {
      if (this!.data is List) {
        return List<T>.from(this!.data.map((e) => model.fromJson(e)));
      } else if (this!.data is Map<String, dynamic>) {
        return model.fromJson(this!.data);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      customSnackBar(context, message: "Bir Hata Meydana Geldi - E001");
      return null;
    }
  }
}
