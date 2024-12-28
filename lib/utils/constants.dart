import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  static String baseUrl = 'http://192.168.254.18:8000/';
  static String loginEndpoint = 'api/auth/login/';
  static String registerEndpoint = 'api/auth/register/';
  static String profileEndpoint = 'api/auth/profile/';
  static String updateProfilePictureEndpoint = 'api/auth/profile-picture/';
  static String membersEndpoint = 'api/members/';

  static Future<void> setBaseUrl(String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("baseUrl", url);
    baseUrl = url;
  }

  static Future<void> loadBaseUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    baseUrl = prefs.getString("baseUrl") ?? baseUrl;
  }
}

String titleCase(String input) {
  if (input.isEmpty) {
    return input;
  }

  List<String> words = input.toLowerCase().split(' ');

  for (int i = 0; i < words.length; i++) {
    words[i] = words[i][0].toUpperCase() + words[i].substring(1);
  }

  return words.join(' ');
}

Expanded getExpanded(
    String image, String mainText, String subText, Function()? onTap) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image or Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                "images/$image.png",
                height: 60.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12.0),

            // Main Text
            Text(
              mainText,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8.0),

            // Sub Text
            Text(
              subText,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),

            // Optional Action Arrow
            const SizedBox(height: 10.0),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.0,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    ),
  );
}
