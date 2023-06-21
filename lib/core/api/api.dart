import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_response.dart';
import 'package:dio/dio.dart';

import '../base/base_model.dart';

class Api {
  static Api? _instance;

  static Api? get instance {
    _instance ??= Api._init();
    return _instance;
  }

  Api._init() {
    final baseOptions = BaseOptions(baseUrl: AppConstant.BASE_API_URL);
    _dio = Dio(baseOptions);
  }

  setToken(String token) {
    _dio!.options.headers = {"Authorization": "Bearer $token"};
  }

  deleteToken() {
    _dio!.options.headers["Authorization"] = null;
  }

  Dio? _dio;

  Future post<T extends BaseModel<T>>({required String endPoint, required T responseModel, dynamic body}) async {
    try {
      final response = await _dio!.post(endPoint, data: body);
      if (response.statusCode == 200) {
        final responseBody = response.data;
        if (responseBody is List) {
          return responseBody.map((e) => responseModel.fromJson(e)).toList();
        } else if (responseBody is Map<String, dynamic>) {
          return responseModel.fromJson(responseBody);
        }
        return responseBody;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          if (responseModel is DTOResponse) {
            return DTOResponse(
              success: false,
              message: "UNAUTHORIZED",
            );
          }
        }
        if (e.response!.data != null) {
          if (e.response!.data is Map) {
            if (e.response!.data["message"] != null) {
              return DTOResponse(
                success: false,
                message: e.response!.data["message"] ?? "Beklenmeyen Bir Hata Oluştu",
              );
            }
          }
        }
      }
      return DTOResponse(success: false, message: "Bir Hata Oluştu");
    }
  }

  Future get<T extends BaseModel<T>>({required String endPoint, required T responseModel, dynamic params}) async {
    try {
      final response = await _dio!.get(endPoint, queryParameters: params);
      if (response.statusCode == 200) {
        final responseBody = response.data;
        if (responseBody is List) {
          return responseBody.map((e) => responseModel.fromJson(e)).toList();
        } else if (responseBody is Map<String, dynamic>) {
          return responseModel.fromJson(responseBody);
        }
        return responseBody;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          if (responseModel is DTOResponse) {
            return DTOResponse(
              success: false,
              message: "UNAUTHORIZED",
            );
          }
        }
        if (e.response!.data != null) {
          if (e.response!.data["message"] != null) {
            return DTOResponse(
              success: false,
              message: e.response!.data["message"] ?? "Beklenmeyen Bir Hata Oluştu",
            );
          }
        }
      }

      return DTOResponse(success: false, message: "Bir hata oluştu");
    }
  }
}
