import 'dart:developer';

import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:mobx/mobx.dart';
part 'bank_cards_view_model.g.dart';

class BankCardsViewModel = BankCardsViewModelBase with _$BankCardsViewModel;

abstract class BankCardsViewModelBase with Store {
  @observable
  List<DTOBucket> buckets = [];

  @observable
  bool isLoading = false;

  @action
  Future getBankAccounts() async {
    buckets = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 0);

    if (response != null) {
      buckets = response;
    }

    setLoading(false);
  }

  @action
  setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }
}
