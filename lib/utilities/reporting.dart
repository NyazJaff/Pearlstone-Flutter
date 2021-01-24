import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'http_client.dart';
import 'package:pearlstone/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reporting {
  MyHttpClient httpClient = new MyHttpClient();

  Future<Map<String, dynamic>>
  getSavingCalculation(estimates) async {
    // var reportData = getLocalSavedReport(user.id + "saving_estimate");
    Reporting reporting = new Reporting();
    Map<String, dynamic> calculation = {};

    try{
      await httpClient.makeJsonPost(estimates, url: 'report/saving_calculation').then((response) async {
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

  Future<Map<String, dynamic>>
  sendEstimateReportEmail(user_id, report_id) async {
    Map<String, dynamic> data = {"status": "error"};

    // var reportData = getLocalSavedReport(user.id + "saving_estimate");
    var reportData = {'user_id' : user_id, 'report_id' : report_id};
    String status = 'error';
    try{
      await httpClient.makeJsonPost(reportData, url: 'report/saving_estimate').then((response) async {
        if(response['status'] == 'success'){
          data = response;
        }
      });
      return data;
    }catch (e){
      return data;
    }
  }

  Future<void>
  setLocalEstimateReportData(report) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('EstimateReport', json.encode(report));
  }

  Future<Map<String, dynamic>>
  getLocalEstimateReportData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String reportString = pref.getString('EstimateReport');
    if (reportString == null) {
      return {};
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
    prefs.setString('current_calculation_result_id', id.toString());
  }

  Future<int>
  getEvaluationResultId() async{
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('current_calculation_result_id');
    if (id == null) {
      return null;
    }
    return int.parse(id);
  }
}