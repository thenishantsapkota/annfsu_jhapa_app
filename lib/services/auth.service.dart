import "dart:developer";
import "dart:io";
import "package:annfsu_app/models/auth/profile.model.dart";
import "package:annfsu_app/models/success.model.dart";
import "package:annfsu_app/view/auth/login.view.dart";
import "package:dio/dio.dart" as dio;
import 'package:annfsu_app/models/auth/auth.model.dart';
import "package:annfsu_app/models/error.model.dart";
import "package:annfsu_app/utils/constants.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

class AuthAPIService {
  final dio.Dio _dio = dio.Dio();

  Future<dynamic> login(String email, String password) async {
    try {
      final String url = ApiConstants.baseUrl + ApiConstants.loginEndpoint;

      final dio.Response response =
          await _dio.post(url, data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        Authentication model = Authentication.fromJson(response.data);
        return model;
      } else {
        Errors errors = Errors.fromJson(response.data);
        return errors;
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        log('DioError Response: ${e.response?.data}');
        return Errors.fromJson(e.response?.data ?? {});
      } else {
        log('Dio error: ${e.message}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> loginWithBiometric() async {
    try {
      final String url = ApiConstants.baseUrl + ApiConstants.loginEndpoint;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Object? userPassword = prefs.get("userPassword");
      Object? userEmail = prefs.get("userEmail");

      if (userPassword == null && userEmail == null) {
        Get.offAll(() => const LoginView());
        return;
      }

      final dio.Response response = await _dio
          .post(url, data: {"email": userEmail, "password": userPassword});

      if (response.statusCode == 200) {
        Authentication model = Authentication.fromJson(response.data);
        return model;
      } else {
        Errors errors = Errors.fromJson(response.data);
        return errors;
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        log('DioError Response: ${e.response?.data}');
        return Errors.fromJson(e.response?.data ?? {});
      } else {
        log('Dio error: ${e.message}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> register(
      String email,
      String password,
      String fullName,
      String gender,
      String bloodGroup,
      String contactNumber,
      String address,
      String collegeName,
      String position) async {
    try {
      final String url = ApiConstants.baseUrl + ApiConstants.registerEndpoint;

      final dio.Response response = await _dio.post(url, data: {
        "email": email,
        "password": password,
        "full_name": fullName,
        "gender": gender,
        "blood_group": bloodGroup,
        "contact_number": contactNumber,
        "address": address,
        "college_name": collegeName,
        "position": position
      });

      if (response.statusCode == 200) {
        Authentication model = Authentication.fromJson(response.data);
        return model;
      } else {
        Errors errors = Errors.fromJson(response.data);
        return errors;
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        log('DioError Response: ${e.response?.data}');
        return Errors.fromJson(e.response?.data ?? {});
      } else {
        log('Dio error: ${e.message}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = ApiConstants.baseUrl + ApiConstants.profileEndpoint;
      Object? accessToken = prefs.get("accessToken");

      if (accessToken == null) {
        Get.offAll(() => const LoginView());
        return;
      }

      final dio.Response response = await _dio.get(url,
          options:
              dio.Options(headers: {"Authorization": "Bearer $accessToken"}));

      if (response.statusCode == 200) {
        Profile profile = Profile.fromJson(response.data);
        return profile;
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

  Future<dynamic> updateProfilePicture(File imageFile) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString("accessToken");

      if (accessToken == null) {
        Get.offAll(() => const LoginView());
        return;
      }

      String url =
          "${ApiConstants.baseUrl}${ApiConstants.updateProfilePictureEndpoint}";
      _dio.options.headers["Authorization"] = "Bearer $accessToken";

      String filename = imageFile.path.split("/").last;

      dio.FormData formData = dio.FormData.fromMap({
        "profile_picture": await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: filename,
        ),
      });

      dio.Response response = await _dio.put(url, data: formData);

      if (response.statusCode == 200) {
        return Success.fromJson(response.data);
      } else {
        return Errors.fromJson(response.data);
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        log('DioError Response: ${e.response?.data}');
        return Errors.fromJson(e.response?.data ?? {});
      } else {
        log('DioError: ${e.message}');
      }
    } catch (e) {
      log("Unexpected error: $e");
      throw Exception("Error updating profile picture: $e");
    }
  }
}
