import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/datetime_extension.dart';
import 'package:aile_cuzdani/core/extensions/string_extension.dart';
import 'package:aile_cuzdani/core/model/dto_family.dart';
import 'package:flutter/material.dart';

Widget familyCard(DTOFamily family, {bool isMineFamily = false, bool isBasvuru = false, required Function() onClick}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 1,
    color: CustomColors.WHITE,
    margin: EdgeInsets.zero,
    child: InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.group,
              color: CustomColors.LIGHT_BLACK,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    family.title.firstCapitalize() ?? "",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    family.created_at!.toDayMonthYearString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: CustomColors.OFF_WHITE,
                borderRadius: BorderRadius.circular(12),
              ),
              child: isMineFamily
                  ? const Icon(
                      Icons.delete_sweep,
                      color: CustomColors.ORANGE,
                      size: 24,
                    )
                  : isBasvuru
                      ? const Icon(
                          Icons.hourglass_bottom,
                          color: CustomColors.ORANGE,
                          size: 24,
                        )
                      : const Icon(
                          Icons.login,
                          color: CustomColors.GREEN,
                          size: 24,
                        ),
            ),
          ],
        ),
      ),
    ),
  );
}
