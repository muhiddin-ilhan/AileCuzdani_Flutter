// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import '../api/bucket/bucket_services.dart';
import '../model/dto_bucket.dart';

class GoldDataScrap {
  static Future<bool> updateAllGoldData(BuildContext context) async {
    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 2);

    if (response == null) {
      return false;
    }
    if (response.isEmpty) {
      return false;
    }

    List<DTOBucket>? gramAltins = response.where((element) => element.gold_type == "Gram Altın").toList();
    if (gramAltins.isNotEmpty) {
      bool resultGram = await _updateGramAltin(gramAltins);

      if (!resultGram) {
        customSnackBar(context, message: "Gram Altınların Fiyatı Güncellenemedi - E16");
        return false;
      }

      bool updateGramResult = await BucketServices.bulkEditBucket(gramAltins);

      if (!updateGramResult) {
        customSnackBar(context, message: "Gram Altınların Fiyatı Güncellenemedi - E17");
        return false;
      }
    }

    List<DTOBucket>? altins = response.where((element) => element.gold_type != "Gram Altın").toList();
    if (altins.isNotEmpty) {
      bool resultAltin = await _updateOtherAltin(altins);

      if (!resultAltin) {
        customSnackBar(context, message: "Altınların Fiyatı Güncellenemedi");
        return false;
      }

      bool updateOtherAltinResult = await BucketServices.bulkEditBucket(altins);

      if (!updateOtherAltinResult) {
        customSnackBar(context, message: "Altınların Fiyatı Güncellenemedi");
        return false;
      }
    }

    return true;
  }

  static Future<bool> _updateOtherAltin(List<DTOBucket> altins) async {
    final response = await http.Client().get(Uri.parse('https://canlidoviz.com/altin-fiyatlari'));
    if (response.statusCode == 200) {
      Document document = parser.parse(response.body);
      try {
        var result = document.getElementsByClassName("text-primary text-right text-title   ");

        if (result.isEmpty) {
          return false;
        }
        if (result.length < 64) {
          return false;
        }

        for (DTOBucket altin in altins) {
          double deger;
          if (altin.gold_type == "Gram Altın") {
            deger = double.tryParse(result[0].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "Çeyrek Altın") {
            deger = double.tryParse(result[4].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "Yarım Altın") {
            deger = double.tryParse(result[8].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "Tam Altın") {
            deger = double.tryParse(result[12].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "Cumhuriyet Altını") {
            deger = double.tryParse(result[16].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "Ata Altını") {
            deger = double.tryParse(result[24].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "ONS Altın") {
            deger = double.tryParse(result[20].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "14 Ayar Altın") {
            deger = double.tryParse(result[28].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "18 Ayar Altın") {
            deger = double.tryParse(result[32].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "22 Ayar Bilezik") {
            deger = double.tryParse(result[36].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.gold_type == "Gramse Altın") {
            deger = double.tryParse(result[40].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
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

  static Future<bool> _updateGramAltin(List<DTOBucket> gramAltins) async {
    final response = await http.Client().get(Uri.parse('https://canlidoviz.com/altin-fiyatlari/gram-altin'));
    if (response.statusCode == 200) {
      Document document = parser.parse(response.body);
      try {
        var result = document.getElementsByClassName("text-primary text-right text-title ");

        if (result.isEmpty) {
          return false;
        }
        if (result.length < 64) {
          return false;
        }

        for (DTOBucket altin in gramAltins) {
          double deger;
          if (altin.platform == "Serbest Piyasa") {
            deger = double.tryParse(result[0].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Ziraat Bankası") {
            deger = double.tryParse(result[8].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Yapı Kredi") {
            deger = double.tryParse(result[12].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Vakıfbank") {
            deger = double.tryParse(result[16].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "TEB") {
            deger = double.tryParse(result[20].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Şekerbank") {
            deger = double.tryParse(result[24].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Kuveyt Türk") {
            deger = double.tryParse(result[28].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "İş Bankası") {
            deger = double.tryParse(result[32].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "ING Bank") {
            deger = double.tryParse(result[36].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "HSBC") {
            deger = double.tryParse(result[40].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Halkbank") {
            deger = double.tryParse(result[44].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Garanti Bankası") {
            deger = double.tryParse(result[48].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Finansbank") {
            deger = double.tryParse(result[52].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            } else if (altin.platform == "Denizbank") {
              deger = double.tryParse(result[56].text.trim()) ?? -1;
              if (deger != -1 && altin.count != null) {
                altin.money = altin.count! * deger;
              }
            }
          } else if (altin.platform == "Albaraka") {
            deger = double.tryParse(result[60].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Akbank") {
            deger = double.tryParse(result[64].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
            }
          } else if (altin.platform == "Enpara") {
            deger = double.tryParse(result[68].text.trim()) ?? -1;
            if (deger != -1 && altin.count != null) {
              altin.money = altin.count! * deger;
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
