import 'package:aile_cuzdani/core/api/borrow/borrow_services.dart';
import 'package:aile_cuzdani/core/model/dto_borrow.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:mobx/mobx.dart';
part 'borclar_view_model.g.dart';

class BorclarViewModel = BorclarViewModelBase with _$BorclarViewModel;

abstract class BorclarViewModelBase with Store {
  @observable
  List<DTOBorrow> borrows = [];

  @observable
  bool isLoading = false;

  @action
  Future getBorrows() async {
    borrows = [];
    setLoading(true);

    List<DTOBorrow>? response = await BorrowServices.getAllBorrows();

    if (response != null) {
      borrows = response;
    }

    setLoading(false);
  }

  @action
  setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }
}
