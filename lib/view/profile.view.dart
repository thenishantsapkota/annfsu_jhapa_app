import 'dart:io';

import 'package:annfsu_app/models/auth/profile.model.dart';
import 'package:annfsu_app/services/auth.service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:annfsu_app/utils/constants.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:annfsu_app/utils/snackbar.dart';
import 'package:annfsu_app/view/home.view.dart';
import 'package:annfsu_app/view/auth/login.view.dart';
import 'package:annfsu_app/widgets/spinner.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  Profile? _profile;
  bool isRefreshing = false;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final profile = await AuthAPIService().getProfile();
    if (profile is Profile) {
      setState(() {
        _profile = profile;
      });
    } else {
      Get.off(() => const LoginView());
    }
  }

  Future<void> _refreshProfile() async {
    setState(() {
      isRefreshing = true;
    });

    await _fetchProfile();

    setState(() {
      isRefreshing = false;
    });
  }

  Future<void> _pickProfilePicture() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await AuthAPIService().updateProfilePicture(imageFile);
      generateSuccessSnackbar(
          "Success", "Profile picture updated successfully!");
      await _refreshProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.off(const HomeView());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: GlobalColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProfile,
        child: _profile != null
            ? Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _pickProfilePicture,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(
                                  _profile!.data.profilePicture != null &&
                                          _profile!
                                              .data.profilePicture.isNotEmpty
                                      ? "${ApiConstants.baseUrl}${_profile!.data.profilePicture}"
                                      : "https://via.placeholder.com/150", // Placeholder URL
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _profile!.data.fullName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.grey,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                _profile!.data.contactNumber,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.tag, color: Colors.grey),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        _profile!.data.id
                                            .toString()
                                            .padLeft(4, "0"),
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Icon(Icons.person,
                                        color: Colors.grey),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        titleCase(_profile!.data.gender),
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Colors.grey),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        _profile!.data.address,
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Icon(Icons.bloodtype,
                                        color: Colors.grey),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        _profile!.data.bloodGroup,
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Icon(Icons.school,
                                        color: Colors.grey),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        _profile!.data.collegeName,
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Icon(Icons.person_2,
                                        color: Colors.grey),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        _profile!.data.position,
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: isRefreshing
                    ? ModernSpinner(
                        color: GlobalColors.mainColor,
                      )
                    : ModernSpinner(
                        color: GlobalColors.mainColor,
                      ),
              ),
      ),
    );
  }
}
