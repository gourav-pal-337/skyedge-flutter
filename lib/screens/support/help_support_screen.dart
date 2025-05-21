import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/my_appbar.dart';
import 'package:skyedge/theme/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Help & Support'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Top AppBar section

              // Divider(color: Colors.grey.shade800),
              // List Items
              buildSupportItem(
                "FAQs",
                context,
                onTap: () {
                  context.push(AppRoutes.faqScreen);
                },
              ),
              buildSupportItem(
                "Privacy Policy",
                context,
                onTap: () {
                  context.push(AppRoutes.privacyPoliciesScreen);
                },
              ),
              buildSupportItem(
                "Terms & Conditions",
                context,
                onTap: () {
                  context.push(AppRoutes.termConditionScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSupportItem(String title, BuildContext context,
      {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
            dense: true,
            title: Text(title),
            trailing: Icon(Icons.chevron_right, color: AppTheme.greyText),
            onTap: onTap),
        Divider(
          color: AppTheme.grey?.withOpacity(0.5),
          thickness: 0.4,
        ),
      ],
    );
  }
}
