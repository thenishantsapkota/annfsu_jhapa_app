import 'package:annfsu_app/utils/constants.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    this.profilePicture,
    required this.firstName,
  }) : super(key: key);

  final String? profilePicture;
  final String firstName;

  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${widget.firstName}!",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: GlobalColors.mainColor),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Welcome to ANNFSU Jhapa",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: GlobalColors.mainColor,
                                  fontSize: 14.0,
                                ),
                      ),
                    ],
                  ),
                  trailing: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: CachedNetworkImageProvider(
                        widget.profilePicture != null &&
                                widget.profilePicture!.isNotEmpty
                            ? "${ApiConstants.baseUrl}${widget.profilePicture}"
                            : "https://via.placeholder.com/150",
                        scale: 1.0),
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
