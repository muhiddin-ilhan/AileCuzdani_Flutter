import 'package:aile_cuzdani/core/model/dto_user.dart';

class AppSession {
  static final AppSession _instance = AppSession._();

  AppSession._();

  static AppSession get instance => _instance;

  DTOUser? user;

  setUser(DTOUser? value) {
    user = value;
  }
}
