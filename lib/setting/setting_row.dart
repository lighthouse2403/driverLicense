import 'package:flutter/material.dart';
import 'package:license/setting/model/license_model.dart';

class SettingRowWidget extends StatelessWidget {
  SettingRowWidget({super.key, required this.licenseType, required this.selectedLicenseId});

  LicenseTypeModel licenseType;
  int selectedLicenseId = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(
            width: 0.5,
            color: (selectedLicenseId == licenseType.id) ? Colors.green : Colors.grey.withOpacity(0.8)
        )
      ),
      padding: const EdgeInsets.only(left: 10, right: 5, top: 12, bottom: 12),
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Text(
            licenseType.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: (selectedLicenseId == licenseType.id) ? Colors.green : Colors.black
            ),
          ),
          const SizedBox(width: 10,),
          Flexible(
              child: Text(
                licenseType.comment,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                    color: (selectedLicenseId == licenseType.id) ? Colors.green : Colors.black
                ),
              )
          )
        ],
      ),
    );
  }
}

