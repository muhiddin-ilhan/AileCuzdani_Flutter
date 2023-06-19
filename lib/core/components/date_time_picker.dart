// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/components/custom_textbox.dart';
import 'package:flutter/material.dart';

Widget customDateTimePicker(
  BuildContext context, {
  required Function(DateTime) onCompleted,
  required TextEditingController controller,
  required bool loading,
}) {
  return InkWell(
    onTap: loading
        ? null
        : () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime.now(),
              cancelText: "İptal",
              confirmText: "Tamam",
              fieldHintText: "12/10/2000",
              fieldLabelText: "Tarih Seçiniz",
              helpText: "Harcama Tarihi",
              locale: const Locale("tr"),
            );
            TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input,
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
              cancelText: "İptal",
              confirmText: "Tamamla",
              hourLabelText: "",
              minuteLabelText: "",
              errorInvalidText: "Geçersiz Saat",
              helpText: "Saat Seçiniz",
            );

            date ??= DateTime.now();
            time ??= TimeOfDay.now();

            String month =
                date.month < 10 ? "0${date.month}" : date.month.toString();
            String day = date.day < 10 ? "0${date.day}" : date.day.toString();
            String hour =
                time.hour < 10 ? "0${time.hour}" : time.hour.toString();
            String minute =
                time.minute < 10 ? "0${time.minute}" : time.minute.toString();

            String dateTime = "${date.year}-$month-${day}T$hour:$minute:00.000";
            DateTime fullTime = DateTime.parse(dateTime);

            onCompleted(fullTime);
          },
    child: customTextbox(
      context,
      borderRadius: 8,
      fontSize: 14,
      height: 45,
      inputType: TextInputType.text,
      hintText: "Tanım giriniz",
      controller: controller,
      enabled: false,
      prefixIcon: Icon(
        Icons.date_range_rounded,
        color: Colors.black.withOpacity(0.43),
      ),
      textInputAction: TextInputAction.done,
      maxLength: 50,
    ),
  );
}
