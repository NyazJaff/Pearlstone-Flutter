import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'http_client.dart';
import 'package:pearlstone/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reporting {
  MyHttpClient httpClient = new MyHttpClient();

  Future<Map<String, dynamic>>
  getSavingCalculation() async {
    // var reportData = getLocalSavedReport(user.id + "saving_estimate");
    Reporting reporting = new Reporting();
    Map<String, dynamic> calculation = {};

    print(await reporting.getLocalEstimateReportData());
    try{
      await httpClient.makeJsonPost(await reporting.getLocalEstimateReportData(), url: 'report/saving_calculation').then((response) async {
        if(response['status'] == 'success'){
          calculation = response['data'];
          calculation['saving_calculation_id'] = response['saving_calculation_id'];
        }
      });
      return calculation;
    }catch (e){
      return calculation;
    }
  }

  Future<String>
  sendEstimateReportEmail(userId, reportId) async {
    // var reportData = getLocalSavedReport(user.id + "saving_estimate");
    var reportData = {'user_id' : userId, 'report_id' : reportId};
    String status = 'error';
    try{
      await httpClient.makeJsonPost(reportData, url: 'report/saving_estimate').then((response) async {
        if(response['status'] == 'success'){
          status = 'success';
        }else{
          status = response['message'] != null ? response['message'] : 'Failed to login';
        }
      });
      return status;
    }catch (e){
      return 'error';
    }
  }

  Future<void>
  setLocalEstimateReportData(report) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('evaluation_values', json.encode(report));
  }

  Future<Map<String, dynamic>>
  getLocalEstimateReportData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String reportString = pref.getString('evaluation_values');
    if (reportString == null) {
      return null;
    }
    return jsonDecode(reportString);
  }

  Future<void>
  setCurrentEvaluationUserId(id) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('current_evaluation_user', id.toString());
  }

  Future<int>
  getCurrentEvaluationUserId() async{
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('current_evaluation_user');
    if (id == null) {
      return null;
    }
    return int.parse(id);
  }

  Future<void>
  setEvaluationResultId(id) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('current_evaluation_result_id', id.toString());
  }

  Future<int>
  getEvaluationResultId() async{
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('current_evaluation_result_id');
    if (id == null) {
      return null;
    }
    return int.parse(id);
  }
}