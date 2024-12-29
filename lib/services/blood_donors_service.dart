import 'dart:developer';

import 'package:annfsu_app/models/blood_donors/blood_donors.model.dart';
import 'package:annfsu_app/models/error.model.dart';
import 'package:annfsu_app/utils/constants.dart';
import 'package:annfsu_app/view/auth/login.view.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BloodDonorsAPIService {
  final dio.Dio _dio = dio.Dio();

  Future<dynamic> getBloodDonors(String? fullName, String? bloodGroup,
      String? address, String? location) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = ApiConstants.baseUrl + ApiConstants.bloodDonorsEndpoint;
      Object? accessToken = prefs.get("accessToken");

      if (accessToken == null) {
        Get.offAll(() => const LoginView());
        return;
      }

      final dio.Response response = await _dio.get(url,
          options:
              dio.Options(headers: {"Authorization": "Bearer $accessToken"}),
          queryParameters: {
            "full_name": fullName,
            "blood_group": bloodGroup,
            "address": address,
            "location": location
          });

      if (response.statusCode == 200) {
        BloodDonors donors = BloodDonors.fromJson(response.data);
        return donors;
      } else {
        Errors errors = Errors.fromJson(response.data);
        return errors;
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        log('DioError Response: ${e.response?.data}');
        return Errors.fromJson(e.response?.data ?? {});
      } else {
        log('DioError: ${e.message}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
