import 'package:intl/intl.dart';

extension CurrencyFormat on double {
  String currencyFormat() {
    String formattedNumber = NumberFormat.currency(
      customPattern: '#,### \u00a4',
      decimalDigits: 2,
      locale: "tr_TR",
      symbol: "",
      name: "",
    ).format(this);

    if (formattedNumber.startsWith(",")) {
      formattedNumber = "0$formattedNumber";
    }

    if (formattedNumber.startsWith("-,")) {
      formattedNumber = "0,00";
    }

    return formattedNumber;
  }
}
