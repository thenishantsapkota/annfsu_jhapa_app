import 'package:annfsu_app/utils/constants.dart';
import 'package:annfsu_app/widgets/button.global.dart';
import 'package:annfsu_app/widgets/text.form.global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetBaseUrlView extends StatefulWidget {
  const SetBaseUrlView({super.key});

  @override
  State<SetBaseUrlView> createState() => _SetBaseUrlViewState();
}

class _SetBaseUrlViewState extends State<SetBaseUrlView> {
  final TextEditingController baseUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBaseUrl();
  }

  Future<void> _loadBaseUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    baseUrlController.text = prefs.getString('baseUrl') ?? ApiConstants.baseUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Base URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormGlobal(
              controller: baseUrlController,
              text: 'Base URL',
              labelText: 'Base URL',
              obscure: false,
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            ButtonGlobal(
                text: "Save",
                onTap: () async {
                  final String newBaseUrl = baseUrlController.text;
                  await ApiConstants.setBaseUrl(newBaseUrl);
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
