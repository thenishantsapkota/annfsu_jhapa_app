import 'dart:developer';

import 'package:annfsu_app/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberProfileView extends StatefulWidget {
  final int id;
  final String name;
  final String position;
  final String phoneNumber;
  final String location;
  final String bloodGroup;
  final String organization;
  final String? profilePicture;

  const MemberProfileView({
    Key? key,
    required this.id,
    required this.name,
    required this.position,
    required this.phoneNumber,
    required this.location,
    required this.bloodGroup,
    required this.organization,
    this.profilePicture,
  }) : super(key: key);

  @override
  State<MemberProfileView> createState() => _MemberProfileViewState();
}

class _MemberProfileViewState extends State<MemberProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Member Profile"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: GlobalColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _showImagePreview(context);
                  },
                  child: Hero(
                    tag: widget.profilePicture ?? "placeholder_image",
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(
                        widget.profilePicture != null &&
                                widget.profilePicture!.isNotEmpty
                            ? "${ApiConstants.baseUrl}${widget.profilePicture}"
                            : "https://via.placeholder.com/150",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    _launchPhoneDialer(widget.phoneNumber);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          widget.phoneNumber,
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                                widget.id.toString().padLeft(4, "0"),
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.grey),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                widget.position,
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.grey),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                widget.location,
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.bloodtype, color: Colors.grey),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                widget.bloodGroup,
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.school, color: Colors.grey),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                widget.organization,
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(Icons.person_2, color: Colors.grey),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                widget.position,
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
      ),
    );
  }

  void _showImagePreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.profilePicture != null &&
                      widget.profilePicture!.isNotEmpty
                  ? "${ApiConstants.baseUrl}${widget.profilePicture}"
                  : "https://via.placeholder.com/150",
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  void _launchPhoneDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch phone dialer';
      }
    } catch (e) {
      log('Error launching phone dialer: $e');
    }
  }
}
