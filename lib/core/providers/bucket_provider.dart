// ignore_for_file: use_build_context_synchronously
import 'package:aile_cuzdani/core/api/bucket/bucket_services.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:flutter/material.dart';

class BucketProvider extends ChangeNotifier {
  List<DTOBucket> _buckets = [];
  List<DTOBucket> get buckets => _buckets;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getBuckets(BuildContext context) async {
    _buckets = [];
    setLoading(true);

    List<DTOBucket>? response = await BucketServices.getAllFamilyBucket();

    if (response != null) {
      _buckets = response;
    }

    setLoading(false);
  }

  reset() {
    _isLoading = false;
    _buckets = [];
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
