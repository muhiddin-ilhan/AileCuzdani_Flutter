// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/extensions/response_extension.dart';
import 'package:aile_cuzdani/core/model/dto_monthly_chart_report.dart';
import 'package:aile_cuzdani/core/model/dto_reports_request.dart';
import 'package:flutter/material.dart';

import '../../model/dto_report_item.dart';
import '../../model/dto_response.dart';
import '../../utils/loading_utils.dart';
import '../api.dart';

class ReportService {
  static Future<DTOMonthlyChartReport?> monthlyChartReport({required String year}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "report/monthly_chart_report",
      responseModel: DTOResponse(),
      body: {"year": year},
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    response!.data = response.convertModel<DTOMonthlyChartReport>(context, model: DTOMonthlyChartReport()) as DTOMonthlyChartReport;

    return response.data;
  }

  static Future<List<DTOReportItem>?> categorizeReport({required DTOReportsRequest request}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "report/categorize_reports",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    response!.data = response.convertModel<DTOReportItem>(context, model: DTOReportItem()) as List<DTOReportItem>;

    return response.data;
  }

  static Future<List<DTOReportItem>?> usersReport({required DTOReportsRequest request}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "report/users_reports",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    response!.data = response.convertModel<DTOReportItem>(context, model: DTOReportItem()) as List<DTOReportItem>;

    return response.data;
  }

  static Future<List<DTOReportItem>?> bucketReport({required DTOReportsRequest request}) async {
    DTOResponse? response = await Api.instance!.post(
      endPoint: "report/bucket_reports",
      responseModel: DTOResponse(),
      body: request,
    );

    BuildContext context = LoadingUtils.instance.mainBuildContext!;

    if (!response.isSuccess(context, checkData: true)) return null;

    response!.data = response.convertModel<DTOReportItem>(context, model: DTOReportItem()) as List<DTOReportItem>;

    return response.data;
  }
}
