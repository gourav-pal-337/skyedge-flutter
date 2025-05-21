import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/feed/widgets/post_card.dart';
import 'package:skyedge/screens/feed/widgets/tokenize_action_popup.dart';
import 'package:skyedge/show_image.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class SocialMediaFeedScreen extends StatefulWidget {
  const SocialMediaFeedScreen({super.key});

  @override
  State<SocialMediaFeedScreen> createState() => _SocialMediaFeedScreenState();
}

class _SocialMediaFeedScreenState extends State<SocialMediaFeedScreen> {
  void showTokenizeActionPopup() async {
    await showDialog(
        context: context,
        builder: (_) => Dialog(child: const TokenizeActionPopup()));
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      showTokenizeActionPopup();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,

      appBar: MyAppBar(
        title: 'Social Media Feed',
        centerTitle: false,
        action: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.grey?.withOpacity(0.2),
              border: Border.all(color: AppTheme.blacktextColor(context)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: ShowImage(
                    imagelink: AppAssets.skyCoin,
                  ),
                ),
                5.horizontalSpace,
                Text(
                  "2 points",
                  style: AppTextStyle.caption12Regular
                      .copyWith(color: AppTheme.blue),
                )
              ],
            ),
          ),
        ],
      ),
      // AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: const BackButton(color: Colors.white),
      //   title: const Text("Social Media Feed",
      //       style: TextStyle(color: Colors.white)),
      //   actions: [
      //     Row(
      //       children: [
      //         Icon(Icons.token, color: Colors.blueAccent),
      //         const SizedBox(width: 4),
      //         Text("2 tokens", style: TextStyle(color: Colors.blueAccent)),
      //         const SizedBox(width: 12),
      //       ],
      //     )
      //   ],
      // ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          PostCard(
            username: 'Ruffles',
            postText:
                'Savoring every bite of this delicious feast! 🍽️✨ What\'s your favorite dish?',
            imageUrl:
                'https://t3.ftcdn.net/jpg/05/13/23/96/360_F_513239634_DffXRx8iekv3Du8p8gFXrvbt1RrKOL0y.jpg',
            likes: 232,
            comments: 27,
            shares: 33,
            badgeCount: 30,
          ),
          PostCard(
            username: 'Ruffles',
            platformIcon:
                "https://cdn.prod.website-files.com/5d66bdc65e51a0d114d15891/64cebdd90aef8ef8c749e848_X-EverythingApp-Logo-Twitter.jpg",
            postText:
                'Engaging in the political landscape is crucial! 🗳️✨ What policies do you think will shape our future the most?',
            likes: 232,
            comments: 33,
            shares: 32,
            badgeCount: 32,
          ),
          PostCard(
            username: 'Ruffles',
            postText:
                'Savoring every bite of this delicious feast! 🍽️✨ What\'s your favorite dish?',
            imageUrl:
                'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg',
            likes: 232,
            comments: 33,
            shares: 32,
            badgeCount: 32,
          ),
          50.verticalSpace,
        ],
      ),
    );
  }
}
