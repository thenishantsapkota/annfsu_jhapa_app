import 'package:annfsu_app/models/members.model.dart';
import 'package:annfsu_app/services/members.service.dart';
import 'package:annfsu_app/utils/constants.dart';
import 'package:annfsu_app/view/auth/login.view.dart';
import 'package:annfsu_app/view/home.view.dart';
import 'package:annfsu_app/view/members/memberProfile.view.dart';
import 'package:annfsu_app/widgets/spinner.widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:annfsu_app/utils/global.colors.dart';

class MembersView extends StatefulWidget {
  const MembersView({Key? key}) : super(key: key);

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  Members? members;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    final membersData = await MembersAPIService().getMembers();
    if (membersData is Members) {
      setState(() {
        members = membersData;
      });
    } else {
      Get.off(() => const LoginView());
    }
  }

  Future<void> _refreshMembers() async {
    setState(() {
      isRefreshing = true;
    });

    await _fetchMembers();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Members"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.off(() => const HomeView());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: GlobalColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMembers,
        child: members != null
            ? ListView.builder(
                itemCount: members!.data.length,
                itemBuilder: (context, index) {
                  final member = members!.data[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          member.profilePicture != null &&
                                  member.profilePicture!.isNotEmpty
                              ? "${ApiConstants.baseUrl}${member.profilePicture}"
                              : "https://via.placeholder.com/150", // Placeholder URL
                        ), // Placeholder image
                        radius: 25,
                      ),
                      title: Text(
                        member.fullName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(member.position),
                      onTap: () {
                        Get.to(() => MemberProfileView(
                              id: member.id,
                              name: member.fullName,
                              position: member.position,
                              phoneNumber: member.contactNumber,
                              location: member.address,
                              bloodGroup: member.bloodGroup,
                              organization: member.collegeName,
                              profilePicture: member.profilePicture,
                            ));
                      },
                    ),
                  );
                },
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
