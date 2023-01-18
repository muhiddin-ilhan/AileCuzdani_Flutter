// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/components/dropdowns/bucket_dropdown.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/bucket/bucket_services.dart';
import '../../model/dto_bucket.dart';
import '../../utils/loading_utils.dart';

Future<bool?> showBetweenCardsTransferPopup(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerKurus = TextEditingController();
  DTOBucket? selectedReceiverBucket;
  DTOBucket? selectedSenderBucket;

  bool loading = false;
  bool error = false;

  setLoading(bool val, Function(void Function()) setState) {
    loading = val;
    LoadingUtils.instance.loading(val);
    setState(() {});
  }

  Provider.of<BucketProvider>(context, listen: false).getBuckets(context);

  List<Widget> getPriceFilterArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Miktar Aralığı",
          style: TextStyle(
            fontFamily: "JosefinSans",
            color: Color.fromARGB(255, 81, 81, 81),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: customTextbox(
                context,
                borderRadius: 8,
                enabled: !loading,
                contentPaddingEdge: const EdgeInsets.only(right: 8),
                textAlign: TextAlign.end,
                fontSize: 13,
                height: 40,
                controller: controller,
                hintText: "0",
                inputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 9,
                prefixIcon: const Icon(Icons.currency_lira_outlined),
                onChanged: (text) {
                  setState(() {});
                },
                isNumber: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                ",",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.VERY_DARK_GREEN,
                ),
              ),
            ),
            Expanded(
              child: customTextbox(
                context,
                borderRadius: 8,
                fontSize: 13,
                height: 40,
                enabled: !loading,
                controller: controllerKurus,
                contentPaddingEdge: const EdgeInsets.only(left: 8),
                hintText: "00",
                inputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: 2,
                onChanged: (text) {
                  setState(() {});
                },
                isNumber: true,
                isMinusNumber: false,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> getSenderBucketDropdownArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Gönderici Kart",
          style: TextStyle(
            fontFamily: "JosefinSans",
            color: Color.fromARGB(255, 81, 81, 81),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
        child: Consumer<BucketProvider>(builder: (_, providerBucket, __) {
          return bucketDropdown(
            onSelected: (DTOBucket? bucket) {
              selectedSenderBucket = bucket;
              setState(() {});
            },
            items: providerBucket.buckets,
            height: 40,
            value: selectedSenderBucket,
            loading: providerBucket.isLoading || loading,
          );
        }),
      ),
    ];
  }

  List<Widget> getReceiverBucketDropdownArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Alıcı Kart",
          style: TextStyle(
            fontFamily: "JosefinSans",
            color: Color.fromARGB(255, 81, 81, 81),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
        child: Consumer<BucketProvider>(builder: (_, providerBucket, __) {
          return bucketDropdown(
            onSelected: (DTOBucket? bucket) {
              selectedReceiverBucket = bucket;
              setState(() {});
            },
            items: providerBucket.buckets,
            height: 40,
            value: selectedReceiverBucket,
            loading: providerBucket.isLoading || loading,
          );
        }),
      ),
    ];
  }

  return showDialog<bool?>(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      error = (int.tryParse(controller.text) ?? -1) < 0 ||
          (int.tryParse(controllerKurus.text) ?? 0) < 0 ||
          controllerKurus.text == "-" ||
          selectedReceiverBucket == null ||
          selectedSenderBucket == null ||
          selectedReceiverBucket?.id == selectedSenderBucket?.id;
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
                ...getPriceFilterArea(setState),
                ...getSenderBucketDropdownArea(setState),
                ...getReceiverBucketDropdownArea(setState),
                button(
                  context,
                  loading: loading,
                  error: error,
                  onTap: () async {
                    setLoading(true, setState);

                    bool response = await BucketServices.transferBetweenBucket(
                      recieverBucketId: selectedReceiverBucket!.id!,
                      senderBucketId: selectedSenderBucket!.id!,
                      money: (double.tryParse("${controller.text}.${controllerKurus.text.isEmpty ? '0' : controllerKurus.text}") ?? 0),
                    );

                    if (response) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
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
        "Kartlar Arası Transfer",
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
