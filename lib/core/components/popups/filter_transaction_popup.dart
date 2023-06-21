// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/components/date_picker.dart';
import 'package:aile_cuzdani/core/components/dropdowns/bucket_dropdown.dart';
import 'package:aile_cuzdani/core/components/dropdowns/user_dropdown.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:aile_cuzdani/core/providers/user_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/view/transactions/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../model/dto_bucket.dart';

Future<bool?> showFilterTransactionPopup(BuildContext context, TransactionsViewModel viewModel) async {
  DateTime? selectedStartDate = viewModel.filterStartDate;
  DateTime? selectedEndDate = viewModel.filterEndDate;
  TextEditingController startPrice = TextEditingController(text: viewModel.filterStartPrice?.toString());
  TextEditingController endPrice = TextEditingController(text: viewModel.filterEndPrice?.toString());
  DTOBucket? selectedBucket = viewModel.filterBucket;
  DTOUser? selectedUser = viewModel.filterUser;
  TextEditingController selectedWords = TextEditingController(text: viewModel.searchWords);

  Provider.of<UserProvider>(context, listen: false).getUsers(context);
  Provider.of<BucketProvider>(context, listen: false).getBuckets(context);
  Provider.of<BucketProvider>(context, listen: false).getCreditCards(context);

  List<Widget> getDateFilterArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Tarih Aralığı",
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
        child: Observer(builder: (_) {
          return Row(
            children: [
              Expanded(
                child: customDatePicker(
                  context,
                  onCompleted: (dateTime) {
                    if (dateTime != null) {
                      selectedStartDate = dateTime;
                      setState(() {});
                    }
                  },
                  lastDate: selectedEndDate,
                  selectedDate: selectedStartDate ?? viewModel.filterStartDate,
                  loading: viewModel.isLoading,
                  isMinify: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: customDatePicker(
                  context,
                  onCompleted: (dateTime) {
                    if (dateTime != null) {
                      selectedEndDate = dateTime.add(const Duration(hours: 23));
                      setState(() {});
                    }
                  },
                  firstDate: selectedStartDate,
                  selectedDate: selectedEndDate ?? viewModel.filterEndDate,
                  loading: viewModel.isLoading,
                  isMinify: true,
                ),
              ),
            ],
          );
        }),
      ),
    ];
  }

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
        child: Observer(builder: (_) {
          return Row(
            children: [
              Expanded(
                child: customTextbox(
                  context,
                  borderRadius: 8,
                  fontSize: 12,
                  isNumber: true,
                  enabled: !viewModel.isLoading,
                  height: 40,
                  contentPaddingHorizontal: 12,
                  hintText: "350",
                  minWidthPrefix: 40,
                  controller: startPrice,
                  maxLength: 8,
                  suffixIcon: const Icon(Icons.currency_lira_rounded),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: customTextbox(
                  context,
                  borderRadius: 8,
                  fontSize: 12,
                  isNumber: true,
                  enabled: !viewModel.isLoading,
                  height: 40,
                  contentPaddingHorizontal: 12,
                  hintText: "500",
                  minWidthPrefix: 40,
                  controller: endPrice,
                  maxLength: 8,
                  suffixIcon: const Icon(Icons.currency_lira_rounded),
                ),
              ),
            ],
          );
        }),
      ),
    ];
  }

  List<Widget> getBucketDropdownArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Kart Seçimi",
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
        child: Observer(builder: (_) {
          return Consumer<BucketProvider>(builder: (_, providerBucket, __) {
            return bucketDropdown(
              onSelected: (DTOBucket? bucket) {
                selectedBucket = bucket;
              },
              items: providerBucket.buckets + providerBucket.creditCards,
              height: 40,
              value: selectedBucket ?? viewModel.filterBucket,
              loading: providerBucket.isLoading || viewModel.isLoading,
            );
          });
        }),
      ),
    ];
  }

  List<Widget> getUserDropdownArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Kişi Seçimi",
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
        child: Observer(builder: (_) {
          return userDropdown(
            context,
            loading: viewModel.isLoading,
            onSelected: (DTOUser? user) {
              selectedUser = user;
              setState(() {});
            },
            value: selectedUser ?? viewModel.filterUser,
          );
        }),
      ),
    ];
  }

  List<Widget> getSearchWordsArea(Function(void Function()) setState) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
        child: Text(
          "Metin İle Arama",
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
        child: Observer(builder: (_) {
          return customTextbox(
            context,
            borderRadius: 8,
            fontSize: 12,
            height: 40,
            contentPaddingHorizontal: 12,
            enabled: !viewModel.isLoading,
            hintText: "Ara...",
            minWidthPrefix: 40,
            controller: selectedWords,
            maxLength: 25,
            suffixIcon: const Icon(Icons.format_list_bulleted_rounded),
          );
        }),
      ),
    ];
  }

  return showDialog<bool?>(
    context: context,
    builder: (_) => StatefulBuilder(builder: (_, setState) {
      return WillPopScope(
        onWillPop: () async {
          if (LoadingUtils.instance.isLoadingActive()) return false;

          return true;
        },
        child: Observer(builder: (_) {
          return Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: CustomColors.OFF_WHITE,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar(),
                  ...getDateFilterArea(setState),
                  ...getPriceFilterArea(setState),
                  ...getSearchWordsArea(setState),
                  ...getBucketDropdownArea(setState),
                  ...getUserDropdownArea(setState),
                  button(
                    context,
                    loading: viewModel.isLoading,
                    onClear: () async {
                      LoadingUtils.instance.loading(true);
                      viewModel.filterClear();
                      await viewModel.getTransactions(context);
                      LoadingUtils.instance.loading(false);

                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
                    },
                    onTap: () async {
                      LoadingUtils.instance.loading(true);

                      viewModel.setFilterStartDate(selectedStartDate);
                      viewModel.setFilterEndDate(selectedEndDate);
                      viewModel.setFilterStartPrice(startPrice.text.isEmpty ? null : int.tryParse(startPrice.text));
                      viewModel.setFilterEndPrice(endPrice.text.isEmpty ? null : int.tryParse(endPrice.text));
                      viewModel.setFilterBucket(selectedBucket);
                      viewModel.setFilterUser(selectedUser);
                      viewModel.setSearchWords(selectedWords.text.isEmpty ? null : selectedWords.text);
                      await viewModel.getTransactions(context);
                      LoadingUtils.instance.loading(false);

                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }),
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
        "Filtre Uygula",
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

Padding button(BuildContext context, {required Function() onTap, required Function() onClear, required bool loading}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Expanded(
          child: customMaterialButton(
            context: context,
            onTap: onTap,
            isLoading: loading,
            text: "Uygula",
            height: 40,
          ),
        ),
        const SizedBox(width: 6),
        customMaterialButton(
          context: context,
          onTap: onClear,
          isLoading: loading,
          enableLoadingAnim: false,
          child: const Icon(Icons.delete_outline, color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 148, 54, 54),
          height: 40,
        ),
      ],
    ),
  );
}
