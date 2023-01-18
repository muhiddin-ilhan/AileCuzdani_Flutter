import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

Widget customDropdown<T>({
  required List<T> items,
  Widget? prefixIcon,
  double? height,
  String? hintText,
  required Function(T?) onChanged,
  required T? value,
  Widget Function(BuildContext, T?)? dropdownBuilder,
  Widget Function(BuildContext, T, bool)? itemBuilder,
  bool enabled = true,
  Future<List<T>> Function(String)? asyncItems,
  Key? key,
}) {
  return Material(
    key: key,
    borderRadius: BorderRadius.circular(8),
    child: Theme(
      data: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: CustomColors.GREEN),
      ),
      child: SizedBox(
        height: height ?? 45,
        child: DropdownSearch<T>(
          asyncItems: asyncItems,
          items: items,
          onChanged: onChanged,
          enabled: enabled,
          selectedItem: value,
          popupProps: PopupProps.menu(
            itemBuilder: itemBuilder,
            menuProps: MenuProps(
              borderRadius: BorderRadius.circular(10),
              backgroundColor: CustomColors.OFF_WHITE,
            ),
          ),
          dropdownBuilder: dropdownBuilder,
          dropdownDecoratorProps: DropDownDecoratorProps(
            textAlignVertical: TextAlignVertical.center,
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: prefixIcon,
              ),
              hintText: "Kart Seçiniz",
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.35), width: 0),
              ),
            ),
          ),
          dropdownButtonProps: const DropdownButtonProps(
            color: CustomColors.WHITE,
            icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    ),
  );
}
