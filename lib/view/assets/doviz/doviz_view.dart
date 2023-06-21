// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/currency_assets_list.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/popups/add_currency_popup.dart';
import 'package:aile_cuzdani/core/components/popups/remove_currency_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/currency_extension.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/scrapping/currency_data_scrap.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/view/assets/doviz/doviz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DovizView extends StatefulWidget {
  const DovizView({super.key});

  @override
  State<DovizView> createState() => _DovizViewState();
}

class _DovizViewState extends State<DovizView> {
  DovizViewModel viewModel = DovizViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DovizViewModel>(
      onPageBuilder: (_) => Scaffold(
        backgroundColor: CustomColors.OFF_WHITE,
        floatingActionButton: addCardButton(),
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Expanded(
            child: Observer(builder: (_) {
              return Column(
                children: [
                  topInfoSection(),
                  currencyAssetsList(
                    viewModel.currencies,
                    onTap: (DTOBucket bucket) async {
                      bool? result = await showRemoveCurrencyPopup(context, bucket: bucket);
                      if (result == true) {
                        LoadingUtils.instance.loading(true);
                        await CurrencyDataScrap.updateAllCurrencyData(context);
                        viewModel.getCurrencies();
                      }
                    },
                    isScroll: false,
                  ),
                  const SizedBox(height: 86),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Column topInfoSection() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.WHITE,
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 1,
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 0),
              )
            ],
          ),
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Toplam Değer",
                  style: TextStyle(
                    color: Color.fromARGB(201, 59, 59, 59),
                    fontFamily: "JosefinSans",
                    fontSize: 13,
                    height: 1,
                  ),
                ),
              ),
              Observer(builder: (_) {
                return Text(
                  "₺${viewModel.totalValue.currencyFormat()}",
                  style: const TextStyle(
                    color: CustomColors.LIGHT_BLACK,
                    fontFamily: "JosefinSans",
                    fontSize: 13,
                    height: 1,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  FloatingActionButton addCardButton() {
    return FloatingActionButton(
      onPressed: () async {
        bool? result = await showAddCurrencyPopup(context);
        if (result == true) {
          LoadingUtils.instance.loading(true);
          await CurrencyDataScrap.updateAllCurrencyData(context);
          viewModel.getCurrencies();
        }
      },
      backgroundColor: CustomColors.DARK_GREEN,
      child: const Icon(Icons.add),
    );
  }

  AppBar appBar(BuildContext context) {
    return customAppBar(context,
        title: "Döviz Varlıklarım",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              LoadingUtils.instance.loading(true);
              bool? result = await CurrencyDataScrap.updateAllCurrencyData(context);
              if (result == true) {
                await viewModel.getCurrencies();
              }
              LoadingUtils.instance.loading(false);
            },
            icon: const Icon(Icons.refresh),
          ),
        ]);
  }
}
