import 'package:annfsu_app/models/auth/auth.model.dart';
import 'package:annfsu_app/models/error.model.dart';
import 'package:annfsu_app/utils/snackbar.dart';
import 'package:annfsu_app/widgets/spinner.widget.dart';
import 'package:flutter/material.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:annfsu_app/widgets/button.global.dart';
import 'package:annfsu_app/widgets/text.form.global.dart';
import 'package:annfsu_app/services/auth.service.dart';
import 'package:annfsu_app/view/auth/login.view.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();

  late final Authentication model;
  late final Errors errors;
  bool isLoading = false;

  // Predefined options for Blood Group and Gender
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  final List<String> genders = ['Male', 'Female', 'Other'];

  String? selectedBloodGroup;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        const Image(
                          image: AssetImage("images/logo.png"),
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "ANNFSU JHAPA",
                          style: TextStyle(
                            color: GlobalColors.mainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Register an account",
                          style: TextStyle(
                            color: GlobalColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Personal Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormGlobal(
                          labelText: "Full Name",
                          controller: fullNameController,
                          obscure: false,
                          text: "Full Name",
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Full name is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormGlobal(
                          labelText: "Email",
                          controller: emailController,
                          obscure: false,
                          text: 'Email',
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required.";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "Enter a valid email address.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormGlobal(
                          labelText: "Password",
                          controller: passwordController,
                          obscure: true,
                          text: 'Password',
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required.";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters long.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Additional Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Custom Blood Group Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ]),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Blood Group',
                              labelStyle: TextStyle(
                                  color: GlobalColors.textColor, fontSize: 16),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              border: InputBorder.none,
                            ),
                            value: selectedBloodGroup,
                            items: bloodGroups.map((String bloodGroup) {
                              return DropdownMenuItem<String>(
                                value: bloodGroup,
                                child: Text(
                                  bloodGroup,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: GlobalColors.textColor),
                                ),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Blood Group is required.";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedBloodGroup = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Custom Gender Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ]),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              labelStyle: TextStyle(
                                  color: GlobalColors.textColor, fontSize: 16),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              border: InputBorder.none,
                            ),
                            value: selectedGender,
                            items: genders.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(
                                  gender,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: GlobalColors.textColor),
                                ),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Gender is required.";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormGlobal(
                          labelText: "Contact Number",
                          controller: contactNumberController,
                          obscure: false,
                          text: "Contact Number",
                          textInputType:
                              const TextInputType.numberWithOptions(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Contact Number is required.";
                            }
                            // if (!RegExp(r'^\d+$').hasMatch(value)) {
                            //   return "Enter a valid contact number.";
                            // }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormGlobal(
                          labelText: "Address",
                          controller: addressController,
                          obscure: false,
                          text: "Address",
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Address is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormGlobal(
                          labelText: "College Name",
                          controller: collegeController,
                          obscure: false,
                          text: "College Name",
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "College name is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormGlobal(
                          labelText: "Position",
                          controller: positionController,
                          obscure: false,
                          text: "Position",
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Position is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ButtonGlobal(
                    text: "Register",
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        dynamic result = await AuthAPIService().register(
                            emailController.text,
                            passwordController.text,
                            fullNameController.text,
                            selectedGender?.toLowerCase() ?? '',
                            selectedBloodGroup ?? '',
                            contactNumberController.text,
                            addressController.text,
                            collegeController.text,
                            positionController.text);

                        if (result is Authentication) {
                          model = result;
                          if (model.success) {
                            Get.off(() => const LoginView());
                            generateSuccessSnackbar("Success", model.message);
                          }
                        } else if (result is Errors) {
                          errors = result;
                          generateErrorSnackbar("Error", errors.message);
                        } else {
                          generateErrorSnackbar(
                              "Error", "Something went wrong!");
                        }
                      } catch (e) {
                        generateErrorSnackbar("Error", e.toString());
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
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
                        const Text("Already have an account?"),
                        InkWell(
                          onTap: () {
                            Get.off(() => const LoginView());
                          },
                          child: Text(
                            " Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
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
