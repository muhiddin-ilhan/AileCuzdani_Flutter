import 'package:package_info_plus/package_info_plus.dart';
import 'package:mobx/mobx.dart';
part 'settings_view_model.g.dart';

class SettingsViewModel = SettingsViewModelBase with _$SettingsViewModel;

abstract class SettingsViewModelBase with Store {
  @observable
  String version = "";

  @action
  Future getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;
  }
}
