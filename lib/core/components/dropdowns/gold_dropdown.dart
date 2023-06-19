import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import 'custom_dropdown.dart';

Widget goldDropdown(BuildContext context, {required Function(String?) onSelected, required String? value}) {
  return customDropdown<String>(
    items: [
      "Gram Altın",
      "Çeyrek Altın",
      "Yarım Altın",
      "Tam Altın",
      "Cumhuriyet Altını",
      "Ata Altını",
      "ONS Altın",
      "14 Ayar Altın",
      "18 Ayar Altın",
      "22 Ayar Bilezik",
      "Gramse Altın",
    ],
    height: 40,
    hintText: "Altın Türü Seçiniz",
    prefixIcon: const Icon(Icons.currency_exchange_rounded),
    dropdownBuilder: (_, String? selectedItem) => Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(
        selectedItem ?? "Altın Türü Seçiniz",
        style: const TextStyle(fontSize: 14),
      ),
    ),
    itemBuilder: (_, String? gold, isSelected) {
      return Container(
        color: CustomColors.WHITE,
        margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColors.DARK_WHITE,
                    ),
                    child: Icon(
                      Icons.currency_exchange_rounded,
                      color: Colors.yellow.shade800,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          gold ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: CustomColors.LIGHT_BLACK,
                            fontFamily: "JosefinSans",
                            fontSize: 14,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    onChanged: onSelected,
    value: value,
  );
}
