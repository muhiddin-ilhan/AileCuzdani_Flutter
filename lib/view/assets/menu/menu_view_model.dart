import 'package:mobx/mobx.dart';
part 'menu_view_model.g.dart';

class MenuViewModel = MenuViewModelBase with _$MenuViewModel;

abstract class MenuViewModelBase with Store {}
