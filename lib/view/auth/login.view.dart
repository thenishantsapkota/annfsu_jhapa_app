import 'package:annfsu_app/models/auth/auth.model.dart';
import 'package:annfsu_app/models/error.model.dart';
import 'package:annfsu_app/services/auth.service.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:annfsu_app/utils/snackbar.dart';
import 'package:annfsu_app/view/auth/base_url.view.dart';
import 'package:annfsu_app/view/home.view.dart';
import 'package:annfsu_app/view/auth/register.view.dart';
import 'package:annfsu_app/widgets/spinner.widget.dart';
import 'package:annfsu_app/widgets/text.form.global.dart';
import 'package:annfsu_app/widgets/button.global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final Errors errors;
  late final Authentication model;
  bool isLoading = false;
  bool isFingerprintAvailable = false;
  int fingerprintAttempts = 0;
  String? environment = dotenv.env["ENVIRONMENT"];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _checkFingerprintAvailability();
  }

  Future<void> _checkFingerprintAvailability() async {
    SharedPreferences pref = await prefs;
    String? userEmail = pref.getString("userEmail");
    String? userPassword = pref.getString("userPassword");

    setState(() {
      isFingerprintAvailable = userEmail != null && userPassword != null;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    if (fingerprintAttempts >= 3) {
      generateErrorSnackbar(
          "Error", "Too many failed attempts, login manually!");
      setState(() {
        isFingerprintAvailable = false;
      });

      return;
    }
    bool canAuthenticate = await auth.canCheckBiometrics;
    if (!canAuthenticate) {
      generateErrorSnackbar("Error", "Biometric authentication not available");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      if (isAuthenticated) {
        dynamic response = await AuthAPIService().loginWithBiometric();
        if (response is Authentication) {
          SharedPreferences pref = await prefs;
          await pref.setString("accessToken", response.data.accessToken);
          await pref.setString("refreshToken", response.data.refreshToken);
          Get.off(() => const HomeView());
        } else if (response is Errors) {
          fingerprintAttempts++;
          generateErrorSnackbar("Error",
              "Authentication failed. Attempt $fingerprintAttempts/3.");
        } else {
          fingerprintAttempts++;
          generateErrorSnackbar("Error",
              "Authentication failed. Attempt $fingerprintAttempts/3.");
        }
      } else {
        fingerprintAttempts++;
        generateErrorSnackbar(
            "Error", "Authentication failed. Attempt $fingerprintAttempts/3.");
      }
    } catch (e) {
      generateErrorSnackbar(
          "Error", "Biometric authentication failed: ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Image(
                                image: AssetImage("images/logo.png"),
                                height: 150,
                                width: 150,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "ANNFSU JHAPA",
                                style: TextStyle(
                                    color: GlobalColors.mainColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "Login to your account",
                                style: TextStyle(
                                    color: GlobalColors.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormGlobal(
                              controller: emailController,
                              obscure: false,
                              labelText: "Email",
                              text: "Email",
                              textInputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormGlobal(
                              controller: passwordController,
                              obscure: true,
                              labelText: "Password",
                              text: "Password",
                              textInputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ButtonGlobal(
                                    text: "Login",
                                    onTap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      try {
                                        dynamic result = await AuthAPIService()
                                            .login(emailController.text,
                                                passwordController.text);
                                        if (result is Authentication) {
                                          model = result;
                                          if (model.success) {
                                            SharedPreferences pref =
                                                await prefs;
                                            await pref.setString("accessToken",
                                                model.data.accessToken);
                                            await pref.setString("refreshToken",
                                                model.data.refreshToken);
                                            await pref.setString("userPassword",
                                                passwordController.text);
                                            await pref.setString("userEmail",
                                                emailController.text);
                                            Get.off(() => const HomeView());
                                            generateSuccessSnackbar(
                                                "Success", model.message);
                                          }
                                        } else if (result is Errors) {
                                          errors = result;
                                          generateErrorSnackbar(
                                              "Error", errors.message);
                                          passwordController.text = "";
                                        } else {
                                          generateErrorSnackbar(
                                              "Error", "Something went wrong!");
                                        }
                                      } catch (e) {
                                        generateErrorSnackbar(
                                            "Error", e.toString());
                                      } finally {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (isFingerprintAvailable)
                                  ElevatedButton(
                                    onPressed: _authenticateWithBiometrics,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: GlobalColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 5),
                                      shadowColor:
                                          Colors.black.withValues(alpha: 0.1),
                                      elevation: 5,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.fingerprint,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (environment == "development")
                              TextButton(
                                  onPressed: () {
                                    Get.to(() => const SetBaseUrlView());
                                  },
                                  child: const Text("Set Base URL")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (!isLoading)
                Container(
                  height: 50,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      InkWell(
                        onTap: () {
                          Get.to(() => const RegisterView());
                        },
                        child: Text(
                          " Register",
                          style: TextStyle(
                              color: GlobalColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: .5),
              child: Center(
                child: ModernSpinner(
                  color: GlobalColors.mainColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
