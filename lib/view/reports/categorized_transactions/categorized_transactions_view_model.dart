import 'package:aile_cuzdani/core/model/dto_transaction.dart';
import 'package:aile_cuzdani/core/model/dto_transaction_request.dart';
import 'package:mobx/mobx.dart';

import '../../../core/api/transaction/transaction_services.dart';
import '../../../core/model/dto_response.dart';
import '../../../core/utils/loading_utils.dart';
part 'categorized_transactions_view_model.g.dart';

class CategorizedTransactionsViewModel = CategorizedTransactionsViewModelBase with _$CategorizedTransactionsViewModel;

abstract class CategorizedTransactionsViewModelBase with Store {
  @observable
  List<DTOTransaction> transactions = [];
  @observable
  bool isLoading = false;

  @action
  Future getTransactions(DTOTransactionRequest transactionRequest) async {
    transactions = [];
    setLoading(true);

    DTOResponse? response = await TransactionService.getTransactions(request: transactionRequest);

    if (response != null) {
      transactions = response.data;
    }

    setLoading(false);
  }

  @action
  setLoading(bool value) {
    isLoading = value;
    LoadingUtils.instance.loading(value);
  }
}
