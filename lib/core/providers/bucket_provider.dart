// ignore_for_file: use_build_context_synchronously
import 'package:aile_cuzdani/core/api/borrow/borrow_services.dart';
import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/model/dto_borrow.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:flutter/material.dart';

class BucketProvider extends ChangeNotifier {
  List<DTOBucket> _buckets = [];
  List<DTOBucket> get buckets => _buckets;

  List<DTOBucket> _creditCards = [];
  List<DTOBucket> get creditCards => _creditCards;

  List<DTOBorrow> _borrows = [];
  List<DTOBorrow> get borrows => _borrows;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getBuckets(BuildContext context) async {
    _buckets = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 0);

    if (response != null) {
      _buckets = response;
    }

    setLoading(false);
  }

  Future getBorrows(BuildContext context) async {
    _buckets = [];
    setLoading(true);

    List<DTOBorrow>? response = await BorrowServices.getAllBorrows();

    if (response != null) {
      _borrows = response;
    }

    setLoading(false);
  }

  Future getCreditCards(BuildContext context) async {
    _creditCards = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket(type: 1);

    if (response != null) {
      _creditCards = response;
    }

    setLoading(false);
  }

  reset() {
    _isLoading = false;
    _creditCards = [];
    _buckets = [];
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
