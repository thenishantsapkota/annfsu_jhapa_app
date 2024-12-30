import 'package:annfsu_app/models/error.model.dart';
import 'package:annfsu_app/models/success.model.dart';
import 'package:annfsu_app/services/blood_donors_service.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:annfsu_app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:annfsu_app/widgets/text.form.global.dart';

Future<void> getBloodRequestDialog(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isCompleted = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Request for Blood',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormGlobal(
                  controller: nameController,
                  text: "Full Name",
                  textInputType: TextInputType.name,
                  obscure: false,
                  labelText: "Enter your name",
                  onChanged: (value) {
                    isCompleted = value.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        bloodTypeController.text.isNotEmpty &&
                        addressController.text.isNotEmpty;
                  },
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: phoneController,
                  text: "Phone Number",
                  textInputType: TextInputType.text,
                  obscure: false,
                  labelText: "Enter your contact number",
                  onChanged: (value) {
                    isCompleted = value.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        bloodTypeController.text.isNotEmpty &&
                        addressController.text.isNotEmpty;
                  },
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: bloodTypeController,
                  text: "Requested Blood Type",
                  textInputType: TextInputType.text,
                  obscure: false,
                  labelText: "Enter requested blood type",
                  onChanged: (value) {
                    isCompleted = value.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        addressController.text.isNotEmpty;
                  },
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: addressController,
                  text: "Address",
                  textInputType: TextInputType.text,
                  obscure: false,
                  labelText: "Enter your address",
                  onChanged: (value) {
                    isCompleted = value.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        bloodTypeController.text.isNotEmpty;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.mainColor),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                onPressed: () async {
                  if (isCompleted) {
                    dynamic response = await BloodDonorsAPIService()
                        .requestBlood(nameController.text, phoneController.text,
                            bloodTypeController.text, addressController.text);
                    if (response is Success) {
                      generateSuccessSnackbar("Success", response.message);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    } else if (response is Errors) {
                      generateErrorSnackbar("Error", response.message);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  } else {
                    generateErrorSnackbar(
                        "Error", "Please fill in all the fields");
                  }
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
