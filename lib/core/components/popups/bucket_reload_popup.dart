// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/scrapping/borsa_data_scrap.dart';
import 'package:aile_cuzdani/core/scrapping/currency_data_scrap.dart';
import 'package:aile_cuzdani/core/scrapping/gold_data_scrap.dart';
import 'package:flutter/material.dart';

import '../../utils/loading_utils.dart';

Future<bool?> showBucketReloadPopup(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        if (LoadingUtils.instance.isLoadingActive()) return false;

        Navigator.pop(context);
        return false;
      },
      child: Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: CustomColors.OFF_WHITE,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: CustomColors.GREEN,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  "Cüzdan Güncelle",
                  style: TextStyle(
                    fontFamily: "JosefinSans",
                    color: CustomColors.WHITE,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Cüzdanınızda bulunan tüm altın, döviz ve hisse varlıklarınızın değerleri piyasa değerleri ile güncellensin mi?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "JosefinSans",
                  letterSpacing: 0.1,
                  height: 1.3,
                  color: Color.fromARGB(255, 48, 48, 48),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: customMaterialButton(
                      context: context,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      isLoading: false,
                      text: "İptal",
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: customMaterialButton(
                      context: context,
                      onTap: () async {
                        LoadingUtils.instance.loading(true);
                        await GoldDataScrap.updateAllGoldData(context);
                        await CurrencyDataScrap.updateAllCurrencyData(context);
                        await BorsaDataScrap.updateAllBorsaData(context);
                        LoadingUtils.instance.loading(false);

                        if (Navigator.canPop(context)) {
                          Navigator.pop(context, true);
                        }
                      },
                      isLoading: false,
                      backgroundColor: CustomColors.GREEN,
                      text: "Tamam",
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
