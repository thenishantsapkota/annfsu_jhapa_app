// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Dashboard"),
        "bloodDonors": MessageLookupByLibrary.simpleMessage("Blood Donors"),
        "closeAppConfirmation": MessageLookupByLibrary.simpleMessage(
            "Do you want to close the app?"),
        "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to logout?"),
        "logoutSuccess":
            MessageLookupByLibrary.simpleMessage("Logged out successfully!"),
        "members": MessageLookupByLibrary.simpleMessage("Members"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "viewAboutUs": MessageLookupByLibrary.simpleMessage("Our Info"),
        "viewBloodDonors":
            MessageLookupByLibrary.simpleMessage("View Blood Donors"),
        "viewMembers": MessageLookupByLibrary.simpleMessage("View Members"),
        "viewProfile": MessageLookupByLibrary.simpleMessage("View Profile"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
