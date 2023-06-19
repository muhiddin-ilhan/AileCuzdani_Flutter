import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class BorcCard extends StatefulWidget {
  const BorcCard({super.key});

  @override
  State<BorcCard> createState() => _BorcCardState();
}

class _BorcCardState extends State<BorcCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.WHITE,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.DARK_WHITE,
                      ),
                      child: const Icon(
                        Icons.payments_rounded,
                        color: CustomColors.DARK_GREEN,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 4),
                          Text(
                            "Ev Kredisi",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: CustomColors.LIGHT_BLACK,
                              fontFamily: "JosefinSans",
                              fontSize: 14,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            "Muhiddin İLHAN",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
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
                Divider(
                  height: 12,
                  color: Colors.grey.withOpacity(0.1),
                  thickness: 1,
                ),
                textArea(
                  title: "Ödenecek Miktar",
                  desc: "₺3667.66",
                  color: CustomColors.LIGHT_BLACK,
                ),
                const SizedBox(height: 8),
                textArea(
                  title: "Toplam Borç",
                  desc: "₺62000",
                  color: Colors.blue.shade900,
                ),
                const SizedBox(height: 8),
                textArea(
                  title: "Son Ödeme Tarihi",
                  desc: "10/06/2023",
                  color: Colors.green.shade900,
                ),
                const SizedBox(height: 8),
                textArea(
                  title: "Ödenecek Taksit",
                  desc: "6",
                  color: Colors.grey.shade900,
                ),
                const SizedBox(height: 8),
                textArea(
                  title: "Vade",
                  desc: "48",
                  color: Colors.grey.shade900,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row textArea({required String title, required String desc, Color? color}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color.fromARGB(201, 59, 59, 59),
              fontFamily: "JosefinSans",
              fontSize: 12,
              height: 1,
            ),
          ),
        ),
        Text(
          desc,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color,
            fontFamily: "JosefinSans",
            fontSize: 13,
            height: 1,
          ),
        ),
      ],
    );
  }
}
