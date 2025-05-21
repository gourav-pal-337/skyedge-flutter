import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/show_image.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> pages = [
    OnboardingContent(
      imagePath: AppAssets.onb1Light,
      imagePathDark: AppAssets.onb1Dark,
      title: "Own what’s yours",
      description:
          "Join the movement to take back control of your data. With Skyedge, your data works for you — not the other way around.",
    ),
    OnboardingContent(
      imagePath: AppAssets.onb2Light,
      imagePathDark: AppAssets.onb2Dark,
      title: "Monetise Effortlessly",
      description:
          "We help you sell your data ethically. No hidden tricks — just transparent rewards. The more you share, the more you earn.",
    ),
    OnboardingContent(
      imagePath: AppAssets.onb3Light,
      imagePathDark: AppAssets.onb3Dark,
      title: "Get Paid for Your Influence",
      description:
          "Post, engage, and grow your presence. Earn SkyTokens for every meaningful interaction on your social feed.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0),
                  )),
                  onPressed: () {
                    context.go(AppRoutes.registrationScreen);
                  },
                  child: Text('Skip',
                      style: AppTextStyle.body16Regular
                          .copyWith(color: AppTheme.greyText, fontSize: 14))),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(content: pages[index]);
                },
              ),
            ),
            Container(
              height: 100,
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  pages.length,
                  (index) {
                    bool isSelected = _currentPage == index;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isSelected ? 15 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(10),
                        color: isSelected
                            ? AppTheme.primaryColorLight
                            : AppTheme.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingContent {
  final String imagePath;
  final String imagePathDark;

  final String title;
  final String description;

  OnboardingContent({
    required this.imagePath,
    required this.imagePathDark,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    bool isDark = AppTheme.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 60),
        Expanded(
          child: ShowImage(
            imagelink: isDark ? content.imagePathDark : content.imagePath,
            boxFit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(content.title, style: AppTextStyle.title24MediumClash),
              const SizedBox(height: 12),
              Text(
                content.description,
                style: AppTextStyle.body16SmallClash,
              ),
            ],
          ),
        )
      ],
    );
  }
}
