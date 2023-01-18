// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/dropdowns/custom_dropdown.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/loading_utils.dart';

Future<bool?> showCurrencyUnitPopup(BuildContext context) async {
  String? selectedCurrencyUnit = "TRY";

  bool loading = false;
  bool error = false;

  setLoading(bool val, Function(void Function()) setState) {
    loading = val;
    LoadingUtils.instance.loading(val);
    setState(() {});
  }

  return showDialog<bool?>(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      error = selectedCurrencyUnit == null;
      return WillPopScope(
        onWillPop: () async {
          if (LoadingUtils.instance.isLoadingActive()) return false;

          return true;
        },
        child: Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: CustomColors.OFF_WHITE,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
                  child: Text(
                    "Para Birimi",
                    style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 81, 81, 81),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 10),
                  child: Consumer<BucketProvider>(builder: (_, providerBucket, __) {
                    return customDropdown<String>(
                      items: ["TRY"],
                      value: selectedCurrencyUnit,
                      height: 40,
                      hintText: "Para Birimi Seçiniz",
                      prefixIcon: const Icon(Icons.currency_lira),
                      onChanged: (String? val) {
                        selectedCurrencyUnit = val;
                        setState(() {});
                      },
                    );
                  }),
                ),
                button(
                  context,
                  loading: loading,
                  error: error,
                  onTap: () async {
                    setLoading(true, setState);

                    if (Navigator.canPop(context)) {
                      Navigator.pop(context, true);
                    }

                    setLoading(false, setState);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

Container appBar() {
  return Container(
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
        "Para Birimi",
        style: TextStyle(
          fontFamily: "JosefinSans",
          color: CustomColors.WHITE,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Padding button(
  BuildContext context, {
  required Function() onTap,
  required bool loading,
  required bool error,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: customMaterialButton(
      context: context,
      onTap: onTap,
      isLoading: loading,
      text: "Tamam",
      height: 40,
      enabled: !error,
    ),
  );
}
