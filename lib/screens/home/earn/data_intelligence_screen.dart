import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/custom_popup.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class DataIntelligenceScreen extends StatefulWidget {
  const DataIntelligenceScreen({super.key});

  @override
  State<DataIntelligenceScreen> createState() => _DataIntelligenceScreenState();
}

class _DataIntelligenceScreenState extends State<DataIntelligenceScreen> {
  final List<String> items = [
    'Data Completeness: Verified that all required fields are present and populated.',
    'Data Accuracy: Cross-checked data entries for correctness and consistency.',
    'Ensured uniform formats across datasets (e.g., date formats, units of measurement).',
    'Confirmed that the data is up-to-date and relevant.',
    'Data Ownership: Assigned clear ownership and accountability for data assets.',
    'Access Controls: Defined and enforce user permissions and access levels.',
    'Compliance Checks: Ensured adherence to regulations like GDPR, HIPAA, or local data protection laws.',
    'Ensured uniform formats across datasets (e.g., date formats, units of measurement).',
    'Confirmed that the data is up-to-date and relevant.',
    'Data Ownership: Assigned clear ownership and accountability for data assets.',
    'Access Controls: Defined and enforce user permissions and access levels.',
    'Compliance Checks: Ensured adherence to regulations like GDPR, HIPAA, or local data protection laws.',
  ];

  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF111111), // Dark background

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Icon and Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ShowImage(
                    height: 17,
                    imagelink: AppAssets.greenChessIcon,
                  ),
                  SizedBox(width: 8),
                  Text('Applying Data Intelligence',
                      style: AppTextStyle.body16Medium),
                ],
              ),
              40.verticalSpace,
              // Checklist
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: items.map((data) {
                      bool isSelected = selectedItems.contains(data);
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isSelected,
                                onChanged: (value) {
                                  if (isSelected) {
                                    selectedItems.remove(data);
                                  } else {
                                    selectedItems.add(data);
                                  }

                                  debugPrint(
                                      'selectedItems: $data : $selectedItems');
                                  setState(() {});
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5),
                                  child: Text(data,
                                      style: AppTextStyle.caption12Regular
                                          .copyWith(color: AppTheme.greyText)),
                                ),
                              )
                            ],
                          ));
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Note

              // Buy Button
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'Note: ',
                      style: AppTextStyle.caption12Medium.copyWith(
                          // color: AppTheme.greyText,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'To proceed with applying data intelligence to your data, please ensure you have the requisite tokens in your account. You can purchase tokens through our platform as needed.',
                      style: AppTextStyle.caption12Medium.copyWith(
                        color: AppTheme.greyText,
                      )),
                ],
              ),
            ),
          ),
          15.verticalSpace,
          SubmitButton(
            icon: ShowImage(
              height: 20,
              imagelink: AppAssets.skyCoin,
            ),
            iconAtFront: false,
            onTap: () {
              showMyCustomPopup(
                context,
                points: 300,
                title: "Data Intelligence Applied",
                description: "50 Tokens are debited from your wallet balance.",
                confirmText: 'null',
                goBackText: 'null',
              );
            },
            // loading: loading,
            isAtBottom: true,
            // tapable: ,
            label: "Buy for 50",
          ),
        ],
      ),
    );
  }
}
