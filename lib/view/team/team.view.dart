import 'dart:async';
import 'package:annfsu_app/utils/constants.dart';
import 'package:annfsu_app/view/auth/login.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:annfsu_app/models/team/team.model.dart';
import 'package:annfsu_app/services/team.service.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:annfsu_app/widgets/spinner.widget.dart';

class TeamView extends StatefulWidget {
  const TeamView({super.key});

  @override
  State<TeamView> createState() => TeamViewState();
}

class TeamViewState extends State<TeamView> {
  Team? _team;
  bool isLoading = true;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), fetchTeam);
  }

  Future<void> fetchTeam() async {
    final team = await TeamAPIService().getTeam();
    if (team is Team) {
      setState(() {
        _team = team;
        isLoading = false;
      });
    } else {
      Get.off(() => const LoginView());
    }
  }

  // Refresh function for swipe-to-refresh
  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    await fetchTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Team", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: GlobalColors.mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh, // Trigger refresh when swiped down
        child: isLoading
            ? const ModernSpinner()
            : Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Expandable section for ANNFSU Core Team
                      ExpansionTile(
                        collapsedBackgroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        initiallyExpanded: true,
                        title: const Text(
                          "ANNFSU Core Team",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        children: [
                          _buildCoreTeam(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Additional sections for other teams can be added here
                      const ExpansionTile(
                        title: Text(
                          "Other Teams",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        collapsedBackgroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        children: [
                          Text(
                            "Content for other teams goes here.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildCoreTeam() {
    return Column(
      children: [
        // Profile for President
        _buildProfile(
          name: _team!.data.presidentName,
          imageUrl: _team!.data.presidentImage.fullSize,
          title: 'President',
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildProfile(
                name: _team!.data.vicePresidentName,
                imageUrl: _team!.data.vicePresidentImage.fullSize,
                title: 'Vice President',
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildProfile(
                name: _team!.data.secretaryName,
                imageUrl: _team!.data.secretaryImage.fullSize,
                title: 'Secretary',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            if (_team!.data.viceSecretaryName1 != null ||
                _team!.data.viceSecretaryName2 != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_team!.data.viceSecretaryName1 != null)
                    Expanded(
                      child: _buildProfile(
                        name: _team!.data.viceSecretaryName1!,
                        imageUrl: _team!.data.viceSecretaryImage1!.fullSize,
                        title: 'Vice Secretary 1',
                      ),
                    ),
                  const SizedBox(width: 15),
                  if (_team!.data.viceSecretaryName2 != null)
                    Expanded(
                      child: _buildProfile(
                        name: _team!.data.viceSecretaryName2!,
                        imageUrl: _team!.data.viceSecretaryImage2!.fullSize,
                        title: 'Vice Secretary 2',
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 20),
          ],
        ),
        Row(
          mainAxisAlignment: _team!.data.viceSecretaryName3 == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (_team!.data.viceSecretaryName3 != null)
              _buildProfile(
                name: _team!.data.viceSecretaryName3!,
                imageUrl: _team!.data.viceSecretaryImage3!.fullSize,
                title: 'Vice Secretary 3',
              ),
            _buildProfile(
              name: _team!.data.treasurerName,
              imageUrl: _team!.data.treasurerImage.fullSize,
              title: 'Treasurer',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfile({
    required String name,
    required String imageUrl,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Open image preview dialog
              _openImagePreview(imageUrl);
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(
                  "${ApiConstants.baseUrl}$imageUrl"),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _openImagePreview(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(20.0),
                  minScale: 1,
                  maxScale: 5.0,
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConstants.baseUrl}$imageUrl",
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:
                      const Text("Close", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
