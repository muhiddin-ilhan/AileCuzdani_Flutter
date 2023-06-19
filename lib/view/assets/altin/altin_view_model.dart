import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:mobx/mobx.dart';
part 'altin_view_model.g.dart';

class AltinViewModel = AltinViewModelBase with _$AltinViewModel;

abstract class AltinViewModelBase with Store {
  @observable
  List<DTOBucket> golds = [];

  @observable
  bool isLoading = false;

  @action
  Future getGolds() async {
    golds = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 2);

    if (response != null) {
      golds = response;
    }

    setLoading(false);
  }

  @action
  setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }
}
