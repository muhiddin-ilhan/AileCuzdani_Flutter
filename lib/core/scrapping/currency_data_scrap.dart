// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import '../api/bucket/bucket_services.dart';
import '../model/dto_bucket.dart';

class CurrencyDataScrap {
  static Future<bool> updateAllCurrencyData(BuildContext context) async {
    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 3);

    if (response == null) {
      return false;
    }
    if (response.isEmpty) {
      return false;
    }

    List<DTOBucket>? dolars = response.where((element) => element.currency_type == "Dolar").toList();
    if (dolars.isNotEmpty) {
      bool resultDolar = await _updateDolar(dolars);

      if (!resultDolar) {
        customSnackBar(context, message: "Dolar Fiyatı Güncellenemedi");
        return false;
      }

      bool updateDolarResult = await BucketServices.bulkEditBucket(dolars);

      if (!updateDolarResult) {
        customSnackBar(context, message: "Dolar Fiyatı Güncellenemedi");
        return false;
      }
    }

    List<DTOBucket>? euros = response.where((element) => element.currency_type == "Euro").toList();
    if (euros.isNotEmpty) {
      bool resultEuro = await _updateEuro(euros);

      if (!resultEuro) {
        customSnackBar(context, message: "Euro Fiyatı Güncellenemedi");
        return false;
      }

      bool updateEuroResult = await BucketServices.bulkEditBucket(euros);

      if (!updateEuroResult) {
        customSnackBar(context, message: "Euro Fiyatı Güncellenemedi");
        return false;
      }
    }

    return true;
  }

  static Future<bool> _updateDolar(List<DTOBucket> dolar) async {
    final response = await http.Client().get(Uri.parse('https://canlidoviz.com/doviz-kurlari/dolar'));
    if (response.statusCode == 200) {
      Document document = parser.parse(response.body);
      try {
        var result = document.getElementsByClassName("text-primary text-right text-title ");

        if (result.isEmpty) {
          return false;
        }
        if (result.length < 72) {
          return false;
        }

        for (DTOBucket item in dolar) {
          double deger;
          if (item.platform == "Serbest Piyasa") {
            deger = double.tryParse(result[0].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Ziraat Bankası") {
            deger = double.tryParse(result[8].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Yapı Kredi") {
            deger = double.tryParse(result[12].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Vakıfbank") {
            deger = double.tryParse(result[16].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "TEB") {
            deger = double.tryParse(result[20].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Şekerbank") {
            deger = double.tryParse(result[24].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Kuveyt Türk") {
            deger = double.tryParse(result[28].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "İş Bankası") {
            deger = double.tryParse(result[32].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "ING Bank") {
            deger = double.tryParse(result[36].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "HSBC") {
            deger = double.tryParse(result[40].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Halkbank") {
            deger = double.tryParse(result[44].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Garanti Bankası") {
            deger = double.tryParse(result[48].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Finansbank") {
            deger = double.tryParse(result[52].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Denizbank") {
            deger = double.tryParse(result[56].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Albaraka") {
            deger = double.tryParse(result[60].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Akbank") {
            deger = double.tryParse(result[64].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Enpara") {
            deger = double.tryParse(result[72].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          }
        }

        return true;
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    }
    return false;
  }

  static Future<bool> _updateEuro(List<DTOBucket> euro) async {
    final response = await http.Client().get(Uri.parse('https://canlidoviz.com/doviz-kurlari/euro'));
    if (response.statusCode == 200) {
      Document document = parser.parse(response.body);
      try {
        var result = document.getElementsByClassName("text-primary text-right text-title ");

        if (result.isEmpty) {
          return false;
        }
        if (result.length < 60) {
          return false;
        }

        for (DTOBucket item in euro) {
          double deger;
          if (item.platform == "Serbest Piyasa") {
            deger = double.tryParse(result[0].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Ziraat Bankası") {
            deger = double.tryParse(result[8].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Yapı Kredi") {
            deger = double.tryParse(result[12].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Vakıfbank") {
            deger = double.tryParse(result[16].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "TEB") {
            deger = double.tryParse(result[20].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Şekerbank") {
            deger = double.tryParse(result[24].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Kuveyt Türk") {
            deger = double.tryParse(result[28].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "İş Bankası") {
            deger = double.tryParse(result[32].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "ING Bank") {
            deger = double.tryParse(result[36].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "HSBC") {
            deger = double.tryParse(result[40].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Halkbank") {
            deger = double.tryParse(result[44].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Garanti Bankası") {
            deger = double.tryParse(result[48].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Finansbank") {
            deger = double.tryParse(result[52].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Denizbank") {
            deger = double.tryParse(result[56].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          } else if (item.platform == "Enpara") {
            deger = double.tryParse(result[60].text.trim()) ?? -1;
            if (deger != -1 && item.count != null) {
              item.money = item.count! * deger;
            }
          }
        }

        return true;
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    }
    return false;
  }
}
