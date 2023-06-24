// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class AppConstant {
  //static const BASE_API_URL = "http://192.168.1.112:3000/api/";
  //static const BASE_API_URL = "http://192.168.1.58:3001/api/";
  static const BASE_API_URL = "http://209.97.187.37:3001/api/";

  static const List<String> categories = ["Market", "Yol", "İş", "Sağlık", "Kişisel", "Fatura", "Borç", "Yemek", "Diğer"];
  static const List<String> categories2 = ["Maaş", "Alacak", "İş", "Diğer"];
}

class Assets {
  static const LANG_ASSET_PATH = "assets/lang";

  static const LOGO = "assets/image/wallet.png";
  static const COIN = "assets/icons/coin.png";
  static const DOLLAR = "assets/icons/dollar.png";
  static const BORSA = "assets/icons/borsa.png";
  static const CRYPTO = "assets/icons/crypto.png";

  static const CIRCLES_ANIM_URL = "assets/anim/circles_anim.json";
  static const TRUCK_ANIM_URL = "assets/anim/truck_anim.json";
  static const SUCCESS_ANIM_URL = "assets/anim/success_anim.json";
  static const BYEBYE_PEOPLE_ANIM_URL = "assets/anim/byebye_people_anim.json";
  static const HOUR_GLASS_ANIM_URL = "assets/anim/hour_glass_anim.json";
  static const LOADING_ANIM_URL = "assets/anim/loading_anim.json";
  static const LOADING_ANIM_DOT_URL = "assets/anim/loading_dot.json";
}

class CustomColors {
  static const SCAFFOLD_BACKGROUND = Color.fromRGBO(225, 225, 225, 1);

  static const DARK_GREY = Color.fromARGB(255, 89, 89, 89);
  static const GREY = Color.fromARGB(255, 114, 114, 114);
  static const LIGHT_GREY = Color.fromARGB(255, 135, 135, 135);

  static const LIGHT_GREEN = Color(0xFF4db6ac);
  static const GREEN = Color(0xFF009688);
  static const DARK_GREEN = Color(0xFF00796B);
  static const VERY_DARK_GREEN = Color.fromARGB(255, 0, 67, 59);

  static const ORANGE = Color(0xFFFF9800);
  static const LIGHT_ORANGE = Color(0xFFFFB74D);
  static const DARK_ORANGE = Color(0xFFF57C00);

  static const WHITE = Color.fromARGB(255, 255, 255, 255);
  static const OFF_WHITE = Color.fromARGB(255, 238, 238, 238);
  static const DARK_WHITE = Color.fromARGB(255, 226, 226, 226);

  static const BLACK = Color.fromARGB(255, 0, 0, 0);
  static const OFF_BLACK = Color.fromARGB(255, 20, 20, 20);
  static const LIGHT_BLACK = Color.fromARGB(255, 40, 40, 40);
}
