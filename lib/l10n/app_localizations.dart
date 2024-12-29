import 'package:flutter/material.dart';

// App Localizations class to handle fetching translations
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Define getter methods for each string
  String get dashboard {
    return _localizedValues[locale.languageCode]?['dashboard'] ?? 'Dashboard';
  }

  String get logoutConfirmation {
    return _localizedValues[locale.languageCode]?['logout_confirmation'] ??
        'Are you sure you want to logout?';
  }

  String get logoutSuccess {
    return _localizedValues[locale.languageCode]?['logout_success'] ??
        'Logged out successfully!';
  }

  String get unimplementedFeature {
    return _localizedValues[locale.languageCode]?['unimplemented_feature'] ??
        'Feature not implemented yet!';
  }

  String get viewProfile {
    return _localizedValues[locale.languageCode]?['view_profile'] ??
        'View Profile';
  }

  String get viewNews {
    return _localizedValues[locale.languageCode]?["view_news"] ?? 'View News';
  }

  String get viewSongs {
    return _localizedValues[locale.languageCode]?["view_songs"] ?? 'View Songs';
  }

  String get viewMembers {
    return _localizedValues[locale.languageCode]?['view_members'] ??
        'View Members';
  }

  String get viewBloodDonors {
    return _localizedValues[locale.languageCode]?['view_blood_donors'] ??
        'View Blood Donors';
  }

  String get ourInfo {
    return _localizedValues[locale.languageCode]?['our_info'] ?? 'Our Info';
  }

  String get confirmation {
    return _localizedValues[locale.languageCode]?['confirmation'] ??
        'Confirmation';
  }

  String get closeApp {
    return _localizedValues[locale.languageCode]?['close_app'] ??
        'Do you want to close the app?';
  }

  String get no {
    return _localizedValues[locale.languageCode]?['no'] ?? 'No';
  }

  String get yes {
    return _localizedValues[locale.languageCode]?['yes'] ?? 'Yes';
  }

  // Map of localized strings
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'dashboard': 'Dashboard',
      'logout_confirmation': 'Are you sure you want to logout?',
      'logout_success': 'Logged out successfully!',
      'unimplemented_feature': 'Feature not implemented yet!',
      'view_profile': 'View Profile',
      'view_members': 'View Members',
      'view_blood_donors': 'View Blood Donors',
      'our_info': 'Our Info',
      'confirmation': 'Confirmation',
      'close_app': 'Do you want to close the app?',
      'no': 'No',
      'yes': 'Yes',
      'view_news': "View News",
      "view_songs": "View Songs"
    },
    'ne': {
      'dashboard': 'ड्यासबोर्ड',
      'logout_confirmation': 'के तपाईं लगआउट गर्न चाहनुहुन्छ?',
      'logout_success': 'सफलतापूर्वक लगआउट गरिएको!',
      'unimplemented_feature': 'यस सुविधा लागू गरिएको छैन!',
      'view_profile': 'प्रोफाइल हेर्नुहोस्',
      'view_members': 'सदस्यहरू हेर्नुहोस्',
      'view_blood_donors': 'रक्तदाता हेर्नुहोस्',
      'our_info': 'हाम्रो जानकारी',
      'confirmation': 'पुष्टिकरण',
      'close_app': 'के तपाईं एप्लिकेसन बन्द गर्न चाहनुहुन्छ?',
      'no': 'होइन',
      'yes': 'हो',
      'view_news': 'समाचार हेर्नुहोस्',
      'view_songs': 'गीतहरू हेर्नुहोस्'
    },
  };
}

// Localizations delegate class for loading AppLocalizations
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ne']
        .contains(locale.languageCode); // Add supported languages here
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
