import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textStyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = List.generate(4, (_) {
    return {
      'title': 'Your data sets have been acquired.',
      'description':
          'Explore the insights and trends derived from our recently acquired datasets.',
      'time': '10min ago',
    };
  });

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Notifications'),
      body: SafeArea(
        child: Column(
          children: [
            // Header

            // Notification list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 20),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => Divider(
                  color: AppTheme.grey?.withOpacity(0.8),
                  height: 0.5,
                  endIndent: 20,
                  indent: 20,
                ),
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Notification icon
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.cardBackgroundColor(context),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.notifications_active,
                              color: AppTheme.greenTextColor(context)),
                        ),
                        SizedBox(width: 12),
                        // Notification text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title']!,
                                  style: AppTextStyle.body14Medium),
                              SizedBox(height: 4),
                              Text(item['description']!,
                                  style: AppTextStyle.button12),
                              SizedBox(height: 6),
                              Text(item['time']!,
                                  style: AppTextStyle.button12.copyWith(
                                      color: AppTheme.greyText, fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
