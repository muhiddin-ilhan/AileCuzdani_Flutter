import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/datetime_extension.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:flutter/material.dart';

import '../../utils/loading_utils.dart';

void showUserDetailPopup(BuildContext context, {required DTOUser user}) {
  List<Widget> area(
      {required String title,
      required String content,
      required IconData icon}) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomColors.DARK_WHITE,
            ),
            child: Icon(
              icon,
              color: CustomColors.BLACK.withOpacity(0.6),
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color.fromARGB(177, 59, 59, 59),
                    fontFamily: "JosefinSans",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color.fromARGB(245, 59, 59, 59),
                    fontFamily: "JosefinSans",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        if (LoadingUtils.instance.isLoadingActive()) return false;

        return true;
      },
      child: Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: CustomColors.OFF_WHITE,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: CustomColors.GREEN,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  "Kişi Bilgileri",
                  style: TextStyle(
                    fontFamily: "JosefinSans",
                    color: CustomColors.WHITE,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...area(
                    title: "Ad Soyad",
                    content: "${user.name} ${user.surname}",
                    icon: Icons.person,
                  ),
                  const Divider(),
                  ...area(
                    title: "Email",
                    content: "${user.email}",
                    icon: Icons.email_rounded,
                  ),
                  const Divider(),
                  ...area(
                    title: "Oluşturma Tarihi",
                    content: user.created_at!.toMonthNameFullDate(),
                    icon: Icons.date_range,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: customMaterialButton(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                },
                isLoading: false,
                text: "Kapat",
                height: 35,
                backgroundColor: CustomColors.ORANGE,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
