import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/api/transaction/transaction_services.dart';
import '../../core/model/dto_bucket.dart';
import '../../core/model/dto_response.dart';
import '../../core/model/dto_total_values.dart';
import '../../core/model/dto_transaction.dart';
import '../../core/model/dto_transaction_request.dart';
import '../../core/model/dto_user.dart';
import '../../core/utils/expense_enum.dart';
import '../../core/utils/loading_utils.dart';
part 'transactions_view_model.g.dart';

class TransactionsViewModel = TransactionsViewModelBase with _$TransactionsViewModel;

abstract class TransactionsViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  List<DTOTransaction> transactions = [];
  @observable
  DTOTotalValues? totalValues;
  @observable
  String? searchWords;
  @observable
  DTOBucket? filterBucket;
  @observable
  ExpenseState? filterExpenseState;
  @observable
  DTOUser? filterUser;
  @observable
  DateTime? filterStartDate;
  @observable
  DateTime? filterEndDate;
  @observable
  int? filterStartPrice;
  @observable
  int? filterEndPrice;
  @observable
  int? currentPage;
  @observable
  int? totalPage;

  @action
  setSearchWords(String? val) => searchWords = val;

  @action
  setFilterBucket(DTOBucket? val) => filterBucket = val;

  @action
  setFilterUser(DTOUser? val) => filterUser = val;

  @action
  setFilterStartDate(DateTime? val) => filterStartDate = val;

  @action
  setFilterEndDate(DateTime? val) => filterEndDate = val;

  @action
  setFilterStartPrice(int? val) => filterStartPrice = val;

  @action
  setFilterEndPrice(int? val) => filterEndPrice = val;

  @action
  setCurrentPage(int val) => currentPage = val;

  @action
  setTotalPage(int val) => totalPage = val;

  @computed
  bool get isFilterActive =>
      searchWords != null ||
      filterBucket != null ||
      filterUser != null ||
      filterStartDate != null ||
      filterEndDate != null ||
      filterStartPrice != null ||
      filterEndPrice != null;

  @action
  Future getTransactions(BuildContext context, {int? page}) async {
    transactions = [];
    totalValues = null;
    currentPage = null;
    totalPage = null;
    setLoading(true);
    DTOTransactionRequest request = DTOTransactionRequest(
      bucket_id: filterBucket?.id,
      user_id: filterUser?.id,
      is_expense: filterExpenseState?.value,
      sort: "dateDESC",
      words: searchWords,
      start_price: filterStartPrice,
      end_price: filterEndPrice,
      start_date: filterStartDate,
      finish_date: filterEndDate,
      page: page ?? 1,
      limit: 50,
    );

    DTOResponse? response = await TransactionService.getTransactions(request: request);

    if (response != null) {
      if (response.paging != null) {
        transactions = response.data;
        totalValues = response.totalValues;
        currentPage = page ?? 1;
        totalPage = response.paging!.totalPages;
      }
    }

    setLoading(false);
  }

  @action
  filterClear() {
    searchWords = null;
    filterBucket = null;
    filterExpenseState = null;
    filterUser = null;
    filterStartDate = null;
    filterEndDate = null;
    filterStartPrice = null;
    filterEndPrice = null;
    currentPage = null;
    totalPage = null;
  }

  @action
  setLoading(bool value) {
    isLoading = value;
    LoadingUtils.instance.loading(value);
  }
}
