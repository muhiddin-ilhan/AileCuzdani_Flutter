import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/crypto_assets_list.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/popups/add_crypto_popup.dart';
import 'package:aile_cuzdani/core/components/popups/remove_crypto_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/view/assets/cripto/crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CryptoView extends StatefulWidget {
  const CryptoView({super.key});

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  CryptoViewModel viewModel = CryptoViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getCoins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CryptoViewModel>(
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
                  cryptoAssetsList(
                    viewModel.crypto,
                    onTap: (DTOBucket bucket) async {
                      bool? result = await showRemoveCryptoPopup(context, bucket: bucket);
                      if (result == true) {
                        viewModel.getCoins();
                      }
                    },
                    isScroll: false,
                  ),
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
          child: const Row(
            children: [
              Expanded(
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
              Text(
                "₺12300",
                style: TextStyle(
                  color: CustomColors.LIGHT_BLACK,
                  fontFamily: "JosefinSans",
                  fontSize: 13,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  FloatingActionButton addCardButton() {
    return FloatingActionButton(
      onPressed: () async {
        bool? result = await showAddCryptoPopup(context);
        if (result == true) {
          viewModel.getCoins();
        }
      },
      backgroundColor: CustomColors.DARK_GREEN,
      child: const Icon(Icons.add),
    );
  }

  AppBar appBar(BuildContext context) {
    return customAppBar(
      context,
      title: "Kripto Varlıklarım",
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
