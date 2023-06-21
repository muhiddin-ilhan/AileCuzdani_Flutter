// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/borsa_assets_list.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/popups/add_borsa_popup.dart';
import 'package:aile_cuzdani/core/components/popups/remove_BORSA_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/currency_extension.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/scrapping/borsa_data_scrap.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/view/assets/borsa/borsa_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BorsaView extends StatefulWidget {
  const BorsaView({super.key});

  @override
  State<BorsaView> createState() => _BorsaViewState();
}

class _BorsaViewState extends State<BorsaView> {
  BorsaViewModel viewModel = BorsaViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getHisse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BorsaViewModel>(
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
                  borsaAssetsList(
                    viewModel.borsas,
                    onTap: (DTOBucket bucket) async {
                      bool? result = await showRemoveBorsaPopup(context, bucket: bucket);
                      if (result == true) {
                        LoadingUtils.instance.loading(true);
                        await BorsaDataScrap.updateAllBorsaData(context);
                        viewModel.getHisse();
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
        bool? result = await showAddBorsaPopup(context);
        if (result == true) {
          LoadingUtils.instance.loading(true);
          await BorsaDataScrap.updateAllBorsaData(context);
          viewModel.getHisse();
        }
      },
      backgroundColor: CustomColors.DARK_GREEN,
      child: const Icon(Icons.add),
    );
  }

  AppBar appBar(BuildContext context) {
    return customAppBar(context,
        title: "Borsa Varlıklarım",
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
              bool result = await BorsaDataScrap.updateAllBorsaData(context);
              if (result == true) {
                await viewModel.getHisse();
              }
              LoadingUtils.instance.loading(false);
            },
            icon: const Icon(Icons.refresh),
          ),
        ]);
  }
}
