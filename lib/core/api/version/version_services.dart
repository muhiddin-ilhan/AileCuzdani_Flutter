// ignore_for_file: use_build_context_synchronously

import '../../model/dto_response.dart';
import '../api.dart';

class VersionServices {
  static Future<int> checkVersion(String versionNumber) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "version/check_version",
      responseModel: DTOResponse(),
      body: {"version_number": versionNumber},
    );

    if (response != null) {
      if (response.message != null) {
        if (response.message == "False") {
          return -1;
        }
        if (response.message == "True") {
          return 1;
        }
      }
    }

    return 0;
  }
}
