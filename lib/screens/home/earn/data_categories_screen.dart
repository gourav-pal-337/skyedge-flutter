import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/build_context_extensions.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class DataCategoryScreen extends StatefulWidget {
  final void Function(Map data) onNext;
  const DataCategoryScreen({required this.onNext, super.key});

  @override
  State<DataCategoryScreen> createState() => _DataCategoryScreenState();
}

class _DataCategoryScreenState extends State<DataCategoryScreen> {
  final List<String> categories = [
    'Health',
    'Finance',
    'Social Media',
    'Shopping',
    'Social Media',
    'Shopping',
    'Travel',
    'Others',
  ];

  List<int?> selectedIndex = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mediaQuery.size.height * 0.9,
      decoration: BoxDecoration(
        color: AppTheme.cardBackgroundColor(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.verticalSpace,
          Text('What type of data are you uploading?',
              style: AppTextStyle.subtitle20Bold.copyWith(
                color:
                    // Color(0xFFA8FC99)
                    AppTheme.primaryColorDark,
              )),
          const SizedBox(height: 10),
          const Text(
              'Choose a category to help us find apps that match your data type.',
              style: AppTextStyle.caption12Regular),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: 12,
                // crossAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                final isSelected = selectedIndex.contains(index);
                return GestureDetector(
                  onTap: () => setState(() {
                    if (isSelected) {
                      selectedIndex.remove(index);
                    } else {
                      selectedIndex.add(index);
                    }
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppTheme.grey?.withOpacity(0.3),
                        // borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(
                                color: const Color(0xFF9FFFA0), width: 1.5)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 22,
                              width: 22,
                              child: SvgPicture.asset(
                                AppAssets.secureIcon,
                                color: AppTheme.blacktextColor(context),
                              )),
                          // Icon(Icons.security_outlined,
                          //     color: AppTheme.blacktextColor(context)),
                          const SizedBox(height: 8),
                          Text(categories[index],
                              style: AppTextStyle.body14Medium),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // ElevatedButton(
          //   onPressed: selectedIndex != null
          //       ? () {
          //           final selectedCategory = categories[selectedIndex!];
          //           debugPrint('Selected category: $selectedCategory');
          //           // Navigate or filter apps
          //         }
          //       : null,
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color(0xFF9FFFA0),
          //     disabledBackgroundColor: Colors.grey,
          //     minimumSize: const Size.fromHeight(50),
          //     foregroundColor: Colors.black,
          //   ),
          //   child: const Text('Next', style: TextStyle(fontSize: 16)),
          // ),
          SubmitButton(
              onTap: () {
                widget.onNext({'category': selectedIndex});
              },
              label: "Next"),
        ],
      ),
    );
  }
}
