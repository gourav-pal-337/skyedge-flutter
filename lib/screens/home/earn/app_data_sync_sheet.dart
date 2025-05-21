import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/home/earn/widgets/uploading_data_popup.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/build_context_extensions.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class AppDataSyncScreen extends StatefulWidget {
  const AppDataSyncScreen({super.key});

  @override
  State<AppDataSyncScreen> createState() => _AppDataSyncScreenState();
}

class _AppDataSyncScreenState extends State<AppDataSyncScreen> {
  final List<AppData> apps = [
    AppData(
        name: 'Blinkit',
        description:
            'Order all your daily essentials in just 5 minutes with Blinkit!',
        icon:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Blinkit-yellow-rounded.svg/960px-Blinkit-yellow-rounded.svg.png'),
    AppData(
        name: 'Zepto',
        description:
            'Order all your daily essentials and food in just 5 minutes with Zepto!',
        icon:
            'https://yt3.googleusercontent.com/jPBYInRPu1GnBNYwDLdzf3wJb_0U106Xm9tMNX-7KKKOw5QCVK3BwnXWbZ1PDVQF7hyjgBFKlQ=s900-c-k-c0x00ffffff-no-rj'),
    AppData(
        name: 'Zomato',
        description:
            'Order all your food items from your favourite restro with Zomato!',
        icon:
            'https://cdn.iconscout.com/icon/free/png-256/free-zomato-logo-icon-download-in-svg-png-gif-file-formats--food-company-brand-delivery-brans-logos-icons-1637644.png?f=webp'),
    AppData(
        name: 'Swiggy',
        description:
            'Order all your food items from your favourite restro with Swiggy!',
        icon:
            'https://play-lh.googleusercontent.com/ymXDmYihTOzgPDddKSvZRKzXkboAapBF2yoFIeQBaWSAJmC9IUpSPKgvfaAgS5yFxQ'),
    AppData(
        name: 'Uber Eats',
        description:
            'Order all your food items from your favourite restro with Uber Eats!',
        icon:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6VSGDpKsP_2nu9bnxc05vKy_IxJMTp52PMg&s'),
  ];

  final Set<int> selectedIndexes = {0, 1};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: context.mediaQuery.size.height * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.verticalSpace,
            Text('Apps with data in Food Delivery!',
                style: AppTextStyle.subtitle20Bold.copyWith(
                  color:
                      // Color(0xFFA8FC99)
                      AppTheme.primaryColorDark,
                )),
            const SizedBox(height: 8),
            const Text(
              'We found these apps on your device. Select data sources you’d like to upload.',
              style: AppTextStyle.caption12Regular,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: apps.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final app = apps[index];
                  final isSelected = selectedIndexes.contains(index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedIndexes.remove(index);
                        } else {
                          selectedIndexes.add(index);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.grey?.withOpacity(0.4)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: !isSelected
                                  ? AppTheme.grey?.withOpacity(0.4)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ShowImage(
                                imagelink: app.icon,
                                width: 30,
                                height: 30,
                                // fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(app.name,
                                    style: AppTextStyle.subtitle18Medium),
                                const SizedBox(height: 4),
                                Text(
                                  app.description,
                                  style: AppTextStyle.caption12Regular.copyWith(
                                    color: AppTheme.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) {
                              setState(() {
                                if (isSelected) {
                                  selectedIndexes.remove(index);
                                } else {
                                  selectedIndexes.add(index);
                                }
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: AppTheme.primaryColorDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SubmitButton(
                onTap: () {
                  // widget.onNext({'category': selectedIndex});
                  showDialog(
                      context: context,
                      builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: UploadingDataPopup())).then((value) {
                    if (value == true) {
                      context.push(AppRoutes.dataUploadedScreen);
                    }
                  });
                },
                label: "Sync your data"),
          ],
        ),
      ),
    );
  }
}

class AppData {
  final String name;
  final String description;
  final String icon;

  AppData({required this.name, required this.description, required this.icon});
}
