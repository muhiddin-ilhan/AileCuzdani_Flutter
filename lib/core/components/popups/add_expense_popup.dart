// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/transaction/transaction_services.dart';
import 'package:aile_cuzdani/core/components/custom_tooltip.dart';
import 'package:aile_cuzdani/core/components/date_time_picker.dart';
import 'package:aile_cuzdani/core/components/dropdowns/bucket_dropdown.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/components/dropdowns/custom_dropdown.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/datetime_extension.dart';
import 'package:aile_cuzdani/core/extensions/validation_extension.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/model/dto_create_transaction_request.dart';
import 'package:aile_cuzdani/core/model/dto_transaction.dart';
import 'package:aile_cuzdani/core/providers/bucket_provider.dart';
import 'package:aile_cuzdani/core/utils/expense_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../utils/loading_utils.dart';
import '../../utils/shared_preferences.dart';

Future<bool?> showAddIncomePopup(BuildContext context, {ExpenseState state = ExpenseState.expense, DTOTransaction? transaction}) async {
  GlobalKey priceShowCase = GlobalKey();
  GlobalKey cardShowCase = GlobalKey();
  GlobalKey categoryShowCase = GlobalKey();
  GlobalKey dateShowCase = GlobalKey();
  GlobalKey descriptionShowCase = GlobalKey();

  TextEditingController controller = TextEditingController();
  TextEditingController controllerKurus = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerDateTime = TextEditingController(text: DateTime.now().toDateTimeString());

  DTOBucket? selectedBucket;
  String selectedCategory = state == ExpenseState.expense ? AppConstant.categories.first : AppConstant.categories2.first;
  DateTime selectedDateTime = DateTime.now();

  String? errorTitle = "";

  bool loading = false;
  bool isReady = false;

  Provider.of<BucketProvider>(context, listen: false).getBuckets(context);

  if (transaction != null) {
    controller.text = (transaction.price ?? 0.0).toString().split(".")[0];
    if (controller.text.contains("-")) {
      controller.text = controller.text.replaceAll("-", "");
    }
    controllerKurus.text = (transaction.price ?? 0.0).toString().split(".")[1];
    controllerTitle.text = transaction.title ?? "";
    controllerDescription.text = transaction.description ?? "";
    controllerDateTime.text = (transaction.date ?? DateTime.now()).toDateTimeString();

    selectedBucket = transaction.bucket;
    selectedCategory = transaction.category ?? (state == ExpenseState.expense ? AppConstant.categories.first : AppConstant.categories2.first);
    selectedDateTime = transaction.date ?? DateTime.now();

    errorTitle = controllerTitle.text.alphanumericValidation() ? null : "";

    state = transaction.is_expense == 1 ? ExpenseState.expense : ExpenseState.income;
  }

  bool showCase = await SharedManager.instance.getBoolValue("TransactionPopupShowCase") ?? false;

  if (!showCase) {
    ShowCaseWidget.of(context).startShowCase([
      priceShowCase,
      cardShowCase,
      categoryShowCase,
      dateShowCase,
      descriptionShowCase,
    ]);

    await SharedManager.instance.setBoolValue("TransactionPopupShowCase", true);
  }

  setLoading(bool val, Function(void Function()) setState) {
    loading = val;
    LoadingUtils.instance.loading(val);
    setState(() {});
  }

  return showDialog<bool?>(
    context: context,
    builder: (_) => StatefulBuilder(builder: (_, setState) {
      isReady = errorTitle == null && controller.text.isNotEmpty && selectedBucket != null && controllerDateTime.text.isNotEmpty;
      return WillPopScope(
        onWillPop: () async {
          if (LoadingUtils.instance.isLoadingActive()) return false;

          return true;
        },
        child: Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: CustomColors.OFF_WHITE,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                appBar(state, transaction),
                priceTextbox(
                  context,
                  controller,
                  controllerKurus,
                  (text) {
                    setState(() {});
                  },
                  loading,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: Consumer<BucketProvider>(builder: (_, provider, __) {
                    selectedBucket ??= provider.buckets.isNotEmpty ? provider.buckets.first : null;
                    return bucketDropdown(
                      items: provider.buckets,
                      value: selectedBucket,
                      loading: loading || provider.isLoading,
                      onSelected: (DTOBucket? val) {
                        selectedBucket = val;
                        setState(() {});
                      },
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: customDropdown<String>(
                    prefixIcon: const Icon(Icons.category),
                    hintText: "Kategori Seçiniz",
                    enabled: !loading,
                    dropdownBuilder: (_, String? selectedItem) => Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        selectedItem!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    items: state == ExpenseState.expense ? AppConstant.categories : AppConstant.categories2,
                    onChanged: (text) {
                      selectedCategory = text!;
                      setState(() {});
                    },
                    value: selectedCategory,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: customDateTimePicker(
                    context,
                    controller: controllerDateTime,
                    loading: loading,
                    onCompleted: (DateTime dateTime) {
                      controllerDateTime.text = dateTime.toDateTimeString();
                      selectedDateTime = dateTime;
                      setState(
                        () {},
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: customTextbox(
                    context,
                    borderRadius: 8,
                    fontSize: 14,
                    height: 45,
                    enabled: !loading,
                    inputType: TextInputType.text,
                    hintText: "Kısa Açıklama",
                    isCapitalizeSentence: true,
                    controller: controllerTitle,
                    prefixIcon: const Icon(Icons.description),
                    textInputAction: TextInputAction.done,
                    suffixIcon: controllerTitle.text.isNotEmpty && errorTitle != null
                        ? customTooltip(
                            message: "Geçerli bir tanım giriniz lütfen, En fazla 30 karakter",
                            child: const Icon(Icons.warning_amber, color: CustomColors.DARK_GREEN))
                        : null,
                    maxLength: 30,
                    onChanged: (text) {
                      errorTitle = text.alphanumericValidation() ? null : "";
                      setState(
                        () {},
                      );
                    },
                  ),
                ),
                button(
                  context,
                  isReady: isReady,
                  loading: loading,
                  transaction: transaction,
                  onDelete: () async {
                    setLoading(true, setState);

                    bool response = await TransactionService.deleteTransactions(transactionId: transaction!.id!);

                    if (response) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
                    }

                    setLoading(false, setState);
                  },
                  onTap: () async {
                    setLoading(true, setState);

                    DTOCreateTransactionRequest request = DTOCreateTransactionRequest(
                      transaction_id: transaction?.id,
                      bucket_id: selectedBucket!.id,
                      date: selectedDateTime,
                      description: controllerDescription.text,
                      title: controllerTitle.text,
                      price: (double.tryParse("${controller.text}.${controllerKurus.text}") ?? 0) * (state == ExpenseState.expense ? -1 : 1),
                      category: selectedCategory,
                    );

                    bool response;
                    if (transaction != null) {
                      response = await TransactionService.updateTransactions(request: request);
                    } else {
                      response = await TransactionService.createTransactions(request: request);
                    }

                    if (response) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context, true);
                      }
                    }

                    setLoading(false, setState);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

Container appBar(ExpenseState state, DTOTransaction? transaction) {
  return Container(
    height: 40,
    decoration: const BoxDecoration(
      color: CustomColors.GREEN,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    child: Center(
      child: Text(
        transaction != null
            ? 'Güncelle'
            : state == ExpenseState.expense
                ? 'Harcama Ekle'
                : 'Gelir Ekle',
        style: const TextStyle(
          fontFamily: "JosefinSans",
          color: CustomColors.WHITE,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Padding button(
  BuildContext context, {
  required bool isReady,
  required Function() onTap,
  required Function() onDelete,
  required bool loading,
  DTOTransaction? transaction,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Expanded(
          child: customMaterialButton(
            context: context,
            onTap: isReady ? onTap : null,
            isLoading: loading,
            text: "Tamam",
            height: 40,
          ),
        ),
        if (transaction != null) const SizedBox(width: 6),
        if (transaction != null)
          customMaterialButton(
            context: context,
            onTap: isReady ? onDelete : null,
            isLoading: loading,
            enableLoadingAnim: false,
            child: const Icon(Icons.delete_outline, color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 148, 54, 54),
            height: 40,
          ),
      ],
    ),
  );
}

Padding priceTextbox(BuildContext context, TextEditingController controller, TextEditingController controllerKurus, Function(String)? onChanged, bool loading) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: customTextbox(
            context,
            borderRadius: 8,
            enabled: !loading,
            contentPaddingEdge: const EdgeInsets.only(right: 8),
            textAlign: TextAlign.end,
            fontSize: 14,
            height: 45,
            controller: controller,
            hintText: "0",
            inputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 9,
            prefixIcon: const Icon(Icons.currency_lira_outlined),
            onChanged: onChanged,
            isNumber: true,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            ",",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: CustomColors.VERY_DARK_GREEN,
            ),
          ),
        ),
        Expanded(
          child: customTextbox(
            context,
            borderRadius: 8,
            fontSize: 14,
            height: 45,
            enabled: !loading,
            controller: controllerKurus,
            contentPaddingEdge: const EdgeInsets.only(left: 8),
            hintText: "00",
            inputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLength: 2,
            isNumber: true,
            isMinusNumber: false,
          ),
        ),
      ],
    ),
  );
}
