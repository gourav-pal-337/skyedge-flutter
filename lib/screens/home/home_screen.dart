import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/home/widgets/earn_banner.dart';
import 'package:skyedge/screens/home/widgets/leader_board_card.dart';
import 'package:skyedge/screens/home/widgets/my_data_widget.dart';
import 'package:skyedge/screens/home/widgets/recent_data_sales.dart';
import 'package:skyedge/screens/home/widgets/refer_and_earn_card.dart';
import 'package:skyedge/screens/home/widgets/shared_data_card.dart';
import 'package:skyedge/screens/home/widgets/sky_token_card.dart';
import 'package:skyedge/screens/questionnaire/welcome_screen.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EarnBanner(),
              25.verticalSpace,

              SizedBox(
                  height: 200,
                  // width: double.infinity,
                  child: PageView.builder(
                      itemBuilder: (context, index) => const SkyeTokenCard(),
                      itemCount: 10)),
              25.verticalSpace,
              SharedDataCard(),
              25.verticalSpace,

              const RecentDataSalesWidget(),
              LeaderboardCard(
                currentRank: 2,
                message: "Hello",
                onPressed: () {},
              ),
              25.verticalSpace,

              const MyDatasetsWidget(),
              25.verticalSpace,

              ReferAndEarnCard(),
              //  SkyeTokenCard(),
              70.verticalSpace,
            ],
          ),
        ),
      ),
    ));
  }
}
