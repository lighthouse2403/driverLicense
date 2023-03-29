import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:license/Setting/SettingRowWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/LicenseTypeModel.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  
  List<LicenseTypeModel> licenseTypes = [];
  int selectedLicenseId = 2;

  Future<void> getLicenseType() async {
    final String testResponse = await rootBundle.loadString('assets/json/licenseType.json');
    final testData = await json.decode(testResponse);
    licenseTypes = List<LicenseTypeModel>.from(testData["licenseTypes"].map((json) => LicenseTypeModel.fromJson(json)));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Set B2 like default license
    if (prefs.getInt('licenseType') != null) {
      prefs.setInt('licenseType', 2);
    }
  }

  void selectedLicense(LicenseTypeModel license) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('licenseType', license.id);
    selectedLicenseId = license.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: getLicenseType(),
        builder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListView.builder(
              itemCount: licenseTypes.length,
              itemBuilder: (BuildContext context, int index) {
                LicenseTypeModel currentLicenseType = licenseTypes[index];
                return InkWell(
                  onTap: () {
                    selectedLicense(currentLicenseType);
                    setState(() {
                    });
                  },
                  child: SettingRowWidget(licenseType: currentLicenseType, selectedLicenseId: selectedLicenseId,),
                );
              }
            ),
          );
        },
      )
    );
  }
}