import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:mobx/mobx.dart';
part 'doviz_view_model.g.dart';

class DovizViewModel = DovizViewModelBase with _$DovizViewModel;

abstract class DovizViewModelBase with Store {
  @observable
  List<DTOBucket> currencies = [];

  @observable
  bool isLoading = false;

  @action
  Future getCurrencies() async {
    currencies = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 3);

    if (response != null) {
      currencies = response;
    }

    setLoading(false);
  }

  @action
  setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }
}
