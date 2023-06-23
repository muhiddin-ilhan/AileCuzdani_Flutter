// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import '../api/bucket/bucket_services.dart';
import '../model/dto_bucket.dart';

class BorsaDataScrap {
  static Future<bool> updateAllBorsaData(BuildContext context) async {
    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 4);

    if (response == null) {
      return false;
    }
    if (response.isEmpty) {
      return false;
    }

    for (DTOBucket item in response) {
      if (item.title != null) {
        double val = await _updateBorsa(item.title!);
        item.money = val == -1 ? item.money : item.count! * val;
      }
    }

    bool updateBorsaResult = await BucketServices.bulkEditBucket(response);

    if (!updateBorsaResult) {
      customSnackBar(context, message: "Hisse Fiyatı Güncellenemedi");
      return false;
    }

    return true;
  }

  static Future<double> _updateBorsa(String hisseCode) async {
    final response = await http.Client().get(Uri.parse('https://www.google.com/finance/quote/${hisseCode.toUpperCase().trim()}:IST'));
    if (response.statusCode == 200) {
      Document document = parser.parse(response.body);
      try {
        var result = document.getElementsByClassName("YMlKec fxKbKc");

        if (result.isEmpty) {
          return -1;
        }

        if (result[0].text.isEmpty) {
          return -1;
        }

        if (result[0].text.contains("₺")) {
          result[0].text = result[0].text.replaceAll("₺", "");
        }

        return double.tryParse(result[0].text.trim()) ?? -1;
      } catch (e) {
        debugPrint(e.toString());
        return -1;
      }
    }
    return -1;
  }
}
