import 'package:aile_cuzdani/core/extensions/currency_extension.dart';
import 'package:aile_cuzdani/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../model/dto_bucket.dart';
import 'custom_dropdown.dart';

Widget bucketDropdown(
    {required Function(DTOBucket?) onSelected, required List<DTOBucket> items, Key? key, required DTOBucket? value, required bool loading, double? height}) {
  return customDropdown<DTOBucket>(
    key: key,
    prefixIcon: const Icon(Icons.wallet),
    hintText: "Kart Seçiniz",
    height: height,
    dropdownBuilder: (_, DTOBucket? selectedItem) => Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: loading
          ? Text(
              "Yükleniyor...",
              style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)),
            )
          : Text(
              selectedItem != null ? selectedItem.title! : "Kart Seçiniz",
              style: const TextStyle(fontSize: 14),
            ),
    ),
    itemBuilder: (_, item, isSelected) => Container(
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
                    Icons.wallet,
                    color: item.type == 0 ? CustomColors.DARK_GREEN : const Color.fromARGB(255, 96, 40, 112),
                    size: 24,
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
                        item.title.firstCapitalize() ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CustomColors.LIGHT_BLACK,
                          fontFamily: "JosefinSans",
                          fontSize: 14,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "${item.user!.name.firstCapitalize()} ${item.user!.surname.firstCapitalize()}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromARGB(201, 59, 59, 59),
                          fontFamily: "JosefinSans",
                          fontSize: 12,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  item.type == 1 ? "-₺${item.credit_card_borrow!.currencyFormat()}" : "₺${item.money!.currencyFormat()}",
                  style: const TextStyle(
                    color: CustomColors.GREEN,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    onChanged: onSelected,
    value: value,
    items: items,
    enabled: items.isNotEmpty && !loading,
  );
}
