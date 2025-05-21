import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/show_image.dart';

class MyDatasetsWidget extends StatelessWidget {
  const MyDatasetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xFF121212),
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "My Datasets",
                style: AppTextStyle.body14Medium,
              ),
              Text(
                "See all",
                style: AppTextStyle.body14Regular,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Scrollable Cards
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => const DatasetCard(),
            ),
          )
        ],
      ),
    );
  }
}

class DatasetCard extends StatelessWidget {
  const DatasetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackgroundColor(context),
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row with Icon and Menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SvgPicture.asset(AppAssets.secureIcon,
              //  color: Colors.red,
              //     //  AppTheme.blacktextColor(context),
              //     ),
              Icon(Icons.shield, color: AppTheme.blacktextColor(context)),
              Icon(Icons.more_vert,
                  color: AppTheme.blacktextColor(context), size: 18),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Health Data", style: AppTextStyle.body14Medium),
          const SizedBox(height: 4),
          Text("2.4 GB",
              style:
                  AppTextStyle.body14Medium.copyWith(color: AppTheme.greyText)),
          const SizedBox(height: 8),
          const Text(
            "\$345.50",
            style: TextStyle(color: AppTheme.primaryColorDark, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
