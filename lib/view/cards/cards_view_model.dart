import 'package:mobx/mobx.dart';

import '../../core/api/bucket/bucket_services.dart';
import '../../core/model/dto_bucket.dart';
import '../../core/utils/loading_utils.dart';
part 'cards_view_model.g.dart';

class CardsViewModel = CardsViewModelBase with _$CardsViewModel;

abstract class CardsViewModelBase with Store {
  @observable
  List<DTOBucket> buckets = [];

  @observable
  bool isLoading = false;

  @action
  Future getBuckets() async {
    buckets = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket();

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
