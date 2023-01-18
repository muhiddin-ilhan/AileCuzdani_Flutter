import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:aile_cuzdani/core/extensions/datetime_extension.dart';
import 'package:flutter/material.dart';

Widget customDatePicker(
  BuildContext context, {
  required Function(DateTime?) onCompleted,
  required DateTime? selectedDate,
  required bool loading,
  DateTime? firstDate,
  DateTime? lastDate,
  bool isMinify = false,
}) {
  return InkWell(
    onTap: loading
        ? null
        : () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: lastDate != null
                  ? lastDate.isBefore(DateTime.now())
                      ? lastDate
                      : DateTime.now()
                  : DateTime.now(),
              firstDate: firstDate ?? DateTime.now().subtract(const Duration(days: 365)),
              lastDate: lastDate ?? DateTime.now(),
              cancelText: "İptal",
              confirmText: "Tamam",
              fieldHintText: "12/10/2000",
              fieldLabelText: "Tarih Seçiniz",
              helpText: "Tarih Seçiniz",
              locale: const Locale("tr"),
            );

            if (date == null) {
              onCompleted(date);
              return;
            }

            String month = date.month < 10 ? "0${date.month}" : date.month.toString();
            String day = date.day < 10 ? "0${date.day}" : date.day.toString();

            String dateTime = "${date.year}-$month-${day}T00:00:00.000";
            DateTime fullTime = DateTime.parse(dateTime);

            onCompleted(fullTime);
          },
    child: customTextbox(
      context,
      borderRadius: 8,
      fontSize: isMinify ? 12 : 14,
      height: isMinify ? 40 : 45,
      inputType: TextInputType.text,
      contentPaddingHorizontal: 12,
      hintText: "01/01/1990",
      controller: TextEditingController(text: selectedDate != null ? selectedDate.toDayMonthYearString() : ""),
      enabled: false,
      minWidthPrefix: isMinify ? 40 : 60,
      suffixIcon: Icon(
        Icons.date_range_rounded,
        color: Colors.black.withOpacity(0.43),
        size: 22,
      ),
      textInputAction: TextInputAction.done,
      maxLength: 50,
    ),
  );
}
