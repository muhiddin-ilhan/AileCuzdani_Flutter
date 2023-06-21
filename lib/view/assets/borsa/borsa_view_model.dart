import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:mobx/mobx.dart';
part 'borsa_view_model.g.dart';

class BorsaViewModel = BorsaViewModelBase with _$BorsaViewModel;

abstract class BorsaViewModelBase with Store {
  @observable
  List<DTOBucket> borsas = [];
  @observable
  double totalValue = 0;

  @observable
  bool isLoading = false;

  @action
  Future getHisse() async {
    borsas = [];
    totalValue = 0;
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 4);

    if (response != null) {
      borsas = response;
      for (DTOBucket item in response) {
        totalValue += item.money ?? 0;
      }
    }

    setLoading(false);
  }

  @action
  setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }
}
