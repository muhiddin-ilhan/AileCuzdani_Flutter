import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/credit_card_list.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/popups/add_credit_card_popup.dart';
import 'package:aile_cuzdani/core/components/popups/credit_card_pay_borrow_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/view/assets/credit_cards/credit_cards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CreditCardView extends StatefulWidget {
  const CreditCardView({super.key});

  @override
  State<CreditCardView> createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  CreditCardsViewModel viewModel = CreditCardsViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getCreditCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CreditCardsViewModel>(
      onPageBuilder: (_) => Scaffold(
        backgroundColor: CustomColors.OFF_WHITE,
        floatingActionButton: addCardButton(),
        appBar: appBar(context),
        body: Column(
          children: [
            payBorrow(context),
            Observer(
              builder: (_) {
                return Expanded(
                  child: creditCardList(
                    viewModel.creditCards,
                    onTap: (DTOBucket bucket) async {
                      bool? result = await showAddCreditCardPopup(context, isEditing: true, bucket: bucket);
                      if (result == true) {
                        viewModel.getCreditCards();
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding payBorrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: customMaterialButton(
        context: context,
        onTap: () async {
          bool? result = await showCreditCardPayBorrowPopup(context);
          if (result == true) {
            viewModel.getCreditCards();
          }
        },
        isLoading: false,
        backgroundColor: CustomColors.DARK_GREEN,
        child: const Row(
          children: [
            Icon(
              Icons.payments,
              color: CustomColors.WHITE,
            ),
            Spacer(),
            Text(
              "Borç Öde",
              style: TextStyle(color: CustomColors.WHITE),
            ),
            Spacer(),
            SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  FloatingActionButton addCardButton() {
    return FloatingActionButton(
      onPressed: () async {
        bool? result = await showAddCreditCardPopup(context);
        if (result == true) {
          viewModel.getCreditCards();
        }
      },
      backgroundColor: CustomColors.DARK_GREEN,
      child: const Icon(Icons.add_card),
    );
  }

  AppBar appBar(BuildContext context) {
    return customAppBar(
      context,
      title: "Kredi Kartlarım",
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
