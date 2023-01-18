import 'package:aile_cuzdani/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../model/dto_user.dart';
import '../../providers/user_provider.dart';
import 'custom_dropdown.dart';

Widget userDropdown(BuildContext context, {required Function(DTOUser?) onSelected, required DTOUser? value, required bool loading}) {
  return Consumer<UserProvider>(builder: (_, providerUser, __) {
    return customDropdown<DTOUser>(
      items: providerUser.users,
      height: 40,
      hintText: "Kullanıcı Seçiniz",
      prefixIcon: const Icon(Icons.people),
      dropdownBuilder: (_, DTOUser? selectedItem) => Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: providerUser.isLoading
            ? Text(
                "Yükleniyor...",
                style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)),
              )
            : Text(
                selectedItem != null ? "${selectedItem.name} ${selectedItem.surname}" : "Kişi Seçiniz",
                style: const TextStyle(fontSize: 14),
              ),
      ),
      itemBuilder: (_, DTOUser? user, isSelected) {
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
                      child: const Icon(
                        Icons.person,
                        color: CustomColors.DARK_GREEN,
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
                            "${user!.name.firstCapitalize()} ${user.surname.firstCapitalize()}",
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
                            "${user.email}",
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
      onChanged: onSelected,
      value: value,
      enabled: !loading && !providerUser.isLoading,
    );
  });
}
