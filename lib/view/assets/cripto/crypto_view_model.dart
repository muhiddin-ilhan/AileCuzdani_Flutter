import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:mobx/mobx.dart';
part 'crypto_view_model.g.dart';

class CryptoViewModel = CryptoViewModelBase with _$CryptoViewModel;

abstract class CryptoViewModelBase with Store {
  @observable
  List<DTOBucket> crypto = [];

  @observable
  bool isLoading = false;

  @action
  Future getCoins() async {
    crypto = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 5);

    if (response != null) {
      crypto = response;
    }

    setLoading(false);
  }

  @action
  setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }
}
