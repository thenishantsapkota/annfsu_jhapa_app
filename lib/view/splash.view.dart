import 'dart:async';
import 'package:annfsu_app/models/auth/profile.model.dart';
import 'package:annfsu_app/services/auth.service.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:annfsu_app/view/auth/login.view.dart';
import 'package:annfsu_app/view/home.view.dart';
import 'package:annfsu_app/widgets/spinner.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    Timer(const Duration(seconds: 2), () async {
      await checkAccessToken();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<dynamic> checkAccessToken() async {
    var data = await AuthAPIService().getProfile();
    if (data is Profile) {
      Get.off(() => const HomeView());
    } else {
      Get.off(() => const LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: GlobalColors.secondaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("images/logo.png"),
                height: 150,
                width: 150,
              ),
              const Text(
                "ANNFSU Jhapa",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                    height: 40,
                    width: 40,
                    child: ModernSpinner(
                      color: GlobalColors.mainColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
