import 'package:annfsu_app/widgets/blood_request_dialog.dart';
import 'package:flutter/material.dart';
import 'package:annfsu_app/widgets/text.form.global.dart';
import 'package:annfsu_app/services/blood_donors_service.dart';
import 'package:annfsu_app/models/blood_donors/blood_donors.model.dart';
import 'package:annfsu_app/widgets/spinner.widget.dart';
import 'package:annfsu_app/utils/global.colors.dart';
import 'package:annfsu_app/models/error.model.dart';

class BloodDonorsView extends StatefulWidget {
  const BloodDonorsView({Key? key}) : super(key: key);

  @override
  State<BloodDonorsView> createState() => _BloodDonorsViewState();
}

class _BloodDonorsViewState extends State<BloodDonorsView> {
  BloodDonors? bloodDonors;
  List<Datum> allBloodDonors = [];
  bool isRefreshing = false;
  bool isError = false;
  String? searchQuery;
  String errorMessage = '';
  bool isExpanded = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchBloodDonors();
  }

  Future<void> _fetchBloodDonors() async {
    if (isRefreshing) return;

    setState(() {
      isRefreshing = true;
      isError = false;
      errorMessage = '';
    });

    final bloodDonorsData = await BloodDonorsAPIService().getBloodDonors();

    if (bloodDonorsData is BloodDonors) {
      setState(() {
        bloodDonors = bloodDonorsData;
        allBloodDonors = bloodDonorsData.data;
        isRefreshing = false;
      });
    } else if (bloodDonorsData is Errors) {
      setState(() {
        isRefreshing = false;
        isError = true;
        errorMessage = bloodDonorsData.message;
      });
    } else {
      setState(() {
        isRefreshing = false;
        isError = true;
        errorMessage = 'Unknown error occurred';
      });
    }
  }

  Future<void> _refreshBloodDonors() async {
    setState(() {
      bloodDonors = null;
    });
    await _fetchBloodDonors();
  }

  List<Datum> getFilteredDonors() {
    if (searchQuery == null || searchQuery!.isEmpty) {
      return allBloodDonors;
    }

    return allBloodDonors.where((donor) {
      final queryLower = searchQuery!.toLowerCase();
      return donor.fullName.toLowerCase().contains(queryLower) ||
          donor.bloodGroup.toLowerCase().contains(queryLower) ||
          donor.address.toLowerCase().contains(queryLower) ||
          donor.location.toLowerCase().contains(queryLower) ||
          donor.district.toLowerCase().contains(queryLower) ||
          donor.phoneNumber.toLowerCase().contains(queryLower) ||
          donor.emailAddress.toLowerCase().contains(queryLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Donors"),
        centerTitle: true,
        backgroundColor: GlobalColors.mainColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () async {
              await getBloodRequestDialog(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshBloodDonors,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormGlobal(
                      controller: _searchController,
                      text: "Search donors...",
                      textInputType: TextInputType.text,
                      obscure: false,
                      labelText: "Search",
                      onChanged: (value) => {
                        setState(() {
                          searchQuery = value;
                        })
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (isError)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            if (isRefreshing || bloodDonors == null)
              Expanded(
                  child: Center(
                      child: ModernSpinner(color: GlobalColors.mainColor))),
            if (bloodDonors != null && bloodDonors!.data.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'No blood donors found.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            if (bloodDonors != null && getFilteredDonors().isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: getFilteredDonors().length,
                  itemBuilder: (context, index) {
                    final donor = getFilteredDonors()[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: ExpansionTile(
                        title: Text(
                          "${donor.fullName} (${donor.bloodGroup})",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          isExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                        ),
                        onExpansionChanged: (expanded) {
                          setState(() {
                            isExpanded = expanded;
                          });
                        },
                        children: [
                          ListTile(
                            title: Text("Blood Group: ${donor.bloodGroup}"),
                          ),
                          ListTile(
                            title: Text("District: ${donor.district}"),
                          ),
                          ListTile(
                            title: Text("Address: ${donor.address}"),
                          ),
                          ListTile(
                            title: Text("Phone: ${donor.phoneNumber}"),
                          ),
                          ListTile(
                            title: Text("Email: ${donor.emailAddress}"),
                          ),
                          ListTile(
                            title: Text("Location: ${donor.location}"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
