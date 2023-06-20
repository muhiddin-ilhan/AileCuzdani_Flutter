import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/api/transaction/transaction_services.dart';
import '../../core/model/dto_response.dart';
import '../../core/model/dto_total_values.dart';
import '../../core/model/dto_transaction.dart';
import '../../core/utils/loading_utils.dart';
part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  List<DTOTransaction> transactions = [];
  @observable
  DTOTotalValues? totalValues;
  @observable
  ScrollController scrollController = ScrollController();
  @observable
  bool isOtherMenuVisible = true;
  @observable
  int tabIndex = 0;

  @observable
  double fontSizePrice = 20;
  @observable
  double maxFontSizePrice = 20;
  @observable
  double fontSizeTitle = 13;
  @observable
  double maxFontSizeTitle = 13;
  @observable
  double maxIconSize = 30;
  @observable
  double minIconSize = 26;
  @observable
  double iconSize = 30;
  @observable
  double sizedBox = 8;
  @observable
  double maxSizedBox = 8;

  @action
  void scrollListener() {
    double offset = scrollController.offset;
    if (offset / 4 > 30) {
      return;
    }
    if (offset <= 0) {
      offset = 0;
    }

    if (iconSize >= minIconSize && iconSize <= maxIconSize) {
      if (maxIconSize - (offset / 4) < minIconSize) {
        iconSize = minIconSize;
      } else {
        iconSize = maxIconSize - (offset / 4);
      }
    }

    if (sizedBox >= 0) {
      print(sizedBox);
      if (maxSizedBox - (offset / 4) < 0) {
        sizedBox = 0;
      } else {
        sizedBox = maxSizedBox - (offset / 4);
      }
    }

    if (fontSizePrice >= 0) {
      if (maxFontSizePrice - (offset / 4) < 0) {
        fontSizePrice = 0;
      } else {
        fontSizePrice = maxFontSizePrice - (offset / 4);
      }
    }

    if (fontSizeTitle >= 0) {
      if (maxFontSizeTitle - (offset / 4) < 0) {
        fontSizeTitle = 0;
      } else {
        fontSizeTitle = maxFontSizeTitle - (offset / 4);
      }
    }
  }

  @action
  Future getTransactions(BuildContext context) async {
    transactions = [];
    totalValues = null;
    fontSizePrice = 20;
    fontSizeTitle = 13;
    iconSize = 30;
    scrollController.jumpTo(0);
    setLoading(true);

    DTOResponse? response = await TransactionService.getHomeTransaction();

    inspect(response);

    if (response != null) {
      transactions = response.data;
      totalValues = response.totalValues;
    }

    setLoading(false);
  }

  setLoading(bool value) {
    isLoading = value;
    LoadingUtils.instance.loading(value);
  }
}
