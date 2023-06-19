import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:mobx/mobx.dart';
part 'credit_cards_view_model.g.dart';

class CreditCardsViewModel = CreditCardsViewModelBase with _$CreditCardsViewModel;

abstract class CreditCardsViewModelBase with Store {
  @observable
  List<DTOBucket> creditCards = [];

  @observable
  bool isLoading = false;

  @action
  Future getCreditCards() async {
    creditCards = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 1);

    if (response != null) {
      creditCards = response;
    }

    setLoading(false);
  }

  @action
  setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }
}
