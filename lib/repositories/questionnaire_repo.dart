import 'package:skyedge/network/api_endpoints.dart';
import 'package:skyedge/network/api_hitter.dart';
import 'package:skyedge/service/local_storage.dart';
import 'package:skyedge/utils/logger.dart';

class QuestionnaireRepo {
  final ApiHitter _apiClient = ApiHitter();

  Future<ApiResponse?> getRegisterationQuestions() async {
    var token = await MyLocalStorage.getToken();
    try {
      var res =
          await _apiClient.getApiResponse(Endpoints.getRegisterationQuestions);
      return res;
    } catch (e) {
      MyLogger.log(e);
    }
    return null;
  }

  Future<ApiResponse?> submitQuestionnaire(List answers) async {
    var token = await MyLocalStorage.getToken();
    try {
      var res = await _apiClient.getPostApiResponse(
        Endpoints.submitQuestionnaire,
        headers: {"Authorization": "Bearer $token"},
        data: {"answers": answers},
      );
      return res;
    } catch (e) {
      MyLogger.log(e);
    }
    return null;
  }
}
