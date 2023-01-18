import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends StatefulWidget {
  final Widget Function(BuildContext context) onPageBuilder;
  final Function(BuildContext)? initState;
  final Function(BuildContext)? dispose;

  const BaseView({Key? key, required this.onPageBuilder, this.initState, this.dispose}) : super(key: key);

  @override
  BaseViewState<T> createState() => BaseViewState<T>();
}

class BaseViewState<T extends Store> extends State<BaseView<T>> {
  T? model;

  @override
  void initState() {
    super.initState();
    if (widget.initState != null) {
      widget.initState!(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.dispose != null) {
      widget.dispose!(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPageBuilder(context);
  }
}
