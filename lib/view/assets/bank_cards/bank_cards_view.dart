import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/bucket_list.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/popups/add_card_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/view/assets/bank_cards/bank_cards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/components/custom_material_button.dart';
import '../../../core/components/popups/between_cards_transfer_popup.dart';

class BankCardView extends StatefulWidget {
  const BankCardView({super.key});

  @override
  State<BankCardView> createState() => _BankCardViewState();
}

class _BankCardViewState extends State<BankCardView> {
  BankCardsViewModel viewModel = BankCardsViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getBankAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BankCardsViewModel>(
      onPageBuilder: (_) => Scaffold(
        backgroundColor: CustomColors.OFF_WHITE,
        floatingActionButton: addCardButton(),
        appBar: appBar(context),
        body: Column(
          children: [
            transferButton(),
            Expanded(
              child: Observer(
                builder: (context) {
                  return bucketList(
                    viewModel.buckets,
                    onTap: (DTOBucket bucket) async {
                      bool? result = await showAddCardPopup(context, bucket: bucket);

                      if (result == true) {
                        viewModel.getBankAccounts();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton addCardButton() {
    return FloatingActionButton(
      onPressed: () async {
        bool? result = await showAddCardPopup(context);
        if (result == true) {
          viewModel.getBankAccounts();
        }
      },
      backgroundColor: CustomColors.DARK_GREEN,
      child: const Icon(Icons.add_card),
    );
  }

  AppBar appBar(BuildContext context) {
    return customAppBar(
      context,
      title: "Banka Kartlarım",
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  Widget transferButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: customMaterialButton(
          context: context,
          onTap: () async {
            bool? result = await showBetweenCardsTransferPopup(context);
            if (result == true) {
              viewModel.getBankAccounts();
            }
          },
          isLoading: false,
          backgroundColor: CustomColors.DARK_GREEN,
          child: const Row(
            children: [
              Icon(
                Icons.sync_alt,
                color: CustomColors.WHITE,
              ),
              Spacer(),
              Text(
                "Kartlar Arası Transfer",
                style: TextStyle(color: CustomColors.WHITE),
              ),
              Spacer(),
              SizedBox(width: 24),
            ],
          )),
    );
  }
}
