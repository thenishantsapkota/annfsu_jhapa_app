import 'dart:async';
import 'package:annfsu_app/utils/constants.dart';
import 'package:annfsu_app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:annfsu_app/models/auth/profile.model.dart';
import 'package:annfsu_app/services/auth.service.dart';
import 'package:annfsu_app/utils/dialog.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:annfsu_app/widgets/profile.widget.dart';
import 'package:annfsu_app/widgets/spinner.widget.dart';
import 'package:annfsu_app/view/auth/login.view.dart';
import 'package:annfsu_app/view/members/members.view.dart';
import 'package:annfsu_app/view/profile.view.dart';
import 'package:annfsu_app/l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  Profile? _profile;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), fetchProfile);
  }

  Future<void> fetchProfile() async {
    final profile = await AuthAPIService().getProfile();
    if (profile is Profile) {
      setState(() {
        _profile = profile;
      });
    } else {
      Get.off(() => const LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access localized strings
    final localizedStrings = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizedStrings?.dashboard ?? "Dashboard",
            style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              SharedPreferences pref = await prefs;

              showConfirmationDialog(
                  // ignore: use_build_context_synchronously
                  context,
                  localizedStrings?.logoutConfirmation ??
                      "Are you sure you want to logout?", () {
                Get.offAll(() => const LoginView());
                pref.remove("accessToken");
                generateSuccessSnackbar(
                    "Success",
                    localizedStrings?.logoutSuccess ??
                        "Logged out successfully!");
              });
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.translate,
            color: Colors.white,
          ),
          onPressed: () {
            // Switch between languages
            Locale currentLocale = Localizations.localeOf(context);
            Locale newLocale = currentLocale.languageCode == 'en'
                ? const Locale('ne')
                : const Locale('en');
            Get.updateLocale(newLocale);
          },
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: GlobalColors.mainColor,
      ),
      body: WillPopScope(
          onWillPop: () => _onBackButtonPressed(context),
          child: _profile != null
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey.shade300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 140,
                        color: Colors.transparent,
                        child: ProfileWidget(
                          firstName: _profile!.data.fullName,
                          profilePicture:
                              _profile!.data.profilePicture.fullSize,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            getExpanded("profile",
                                localizedStrings?.viewProfile ?? "View Profile",
                                () {
                              Get.to(() => const UserProfileView());
                            }),
                            getExpanded("members",
                                localizedStrings?.viewMembers ?? "View Members",
                                () {
                              Get.to(() => const MembersView());
                            }),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            getExpanded(
                                "blood",
                                localizedStrings?.viewBloodDonors ??
                                    "View Blood Donors", () {
                              generateErrorSnackbar(
                                  localizedStrings?.unimplementedFeature ??
                                      "Unimplemented",
                                  localizedStrings?.unimplementedFeature ??
                                      "Feature not implemented yet!");
                            }),
                            getExpanded("about",
                                localizedStrings?.ourInfo ?? "Our Info", () {
                              generateErrorSnackbar(
                                  localizedStrings?.unimplementedFeature ??
                                      "Unimplemented",
                                  localizedStrings?.unimplementedFeature ??
                                      "Feature not implemented yet!");
                            })
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            getExpanded(
                                "news",
                                localizedStrings?.viewNews ?? "View News",
                                () {}),
                            getExpanded(
                                "songs",
                                localizedStrings?.viewSongs ?? "View Songs",
                                () {}),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: ModernSpinner(
                  color: GlobalColors.mainColor,
                ))),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Confirmation",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              content: const Text(
                "Do you want to close the app?",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(GlobalColors.mainColor),
                      ),
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        )) ??
        false;
  }
}
