import 'package:aile_cuzdani/core/providers/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingUtils {
  static final LoadingUtils instance = LoadingUtils._internal();

  factory LoadingUtils() {
    return instance;
  }

  LoadingUtils._internal();

  BuildContext? mainBuildContext;

  setBuildContext(BuildContext ctx) {
    mainBuildContext = ctx;
  }

  bool isLoadingActive() {
    return Provider.of<LoadingProvider>(mainBuildContext!, listen: false).isLoading;
  }

  loading(bool val) {
    Provider.of<LoadingProvider>(mainBuildContext!, listen: false).loading(val);
  }
}
