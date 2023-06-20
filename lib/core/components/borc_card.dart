import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_borrow.dart';
import 'package:flutter/material.dart';

class BorcCard extends StatefulWidget {
  final DTOBorrow borrows;
  final Function() onTap;

  const BorcCard({super.key, required this.borrows, required this.onTap});

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
          onTap: () {
            widget.onTap();
          },
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            widget.borrows.title ?? "",
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
                            "${widget.borrows.user?.name} ${widget.borrows.user?.surname}",
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
                Divider(
                  height: 12,
                  color: Colors.grey.withOpacity(0.1),
                  thickness: 1,
                ),
                textArea(
                  title: "Ödenecek Miktar",
                  desc: "₺${(widget.borrows.monthly_price ?? 0)}",
                  color: CustomColors.LIGHT_BLACK,
                ),
                const SizedBox(height: 8),
                textArea(
                  title: "Kalan Borç",
                  desc: "₺${(widget.borrows.total_borrow ?? 0)}",
                  color: Colors.blue.shade900,
                ),
                const SizedBox(height: 8),
                textArea(
                  title: "Son Ödeme Tarihi",
                  desc: "${widget.borrows.pay_day}/${((widget.borrows.last_paid_month ?? 0) + 1)}/${DateTime.now().year}",
                  color: Colors.green.shade900,
                ),
                const SizedBox(height: 8),
                textArea(
                  title: "Ödenen Taksit Sayısı",
                  desc: "${widget.borrows.paid_taksit}",
                  color: Colors.grey.shade900,
                ),
                const SizedBox(height: 8),
                textArea(
                  title: "Vade",
                  desc: "${widget.borrows.total_taksit_count}",
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
