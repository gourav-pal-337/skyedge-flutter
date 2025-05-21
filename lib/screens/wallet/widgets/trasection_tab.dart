import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _DateLabel(date: 'Today, 14 April'),
        const _TransactionCard(
          icon: Icons.arrow_outward_rounded,
          title: 'Order (stop-limit)',
          time: '2:30 PM',
          txId: 'SKY12345',
          status: 'Active',
          amount: '-100.00 USDT',
          amountColor: Colors.red,
          statusColor: Colors.blue,
        ),
        const _TransactionCard(
          icon: Icons.arrow_outward_rounded,
          title: 'Sent',
          time: '2:30 PM',
          txId: 'SKY12345',
          status: 'Completed',
          amount: '-100.00 USDT',
          amountColor: Colors.red,
          statusColor: Colors.green,
        ),
        const _TransactionCard(
          icon: Icons.call_received,
          title: 'Received',
          time: '2:30 PM',
          txId: 'SKY12345',
          status: 'Completed',
          amount: '+0.00113888 BTC',
          amountColor: Colors.green,
          statusColor: Colors.green,
        ),
        const _TransactionCard(
          icon: Icons.call_received,
          title: 'Sent',
          time: '2:30 PM',
          txId: 'SKY12345',
          status: 'Failed',
          amount: '0.00113888 BTC',
          amountColor: Colors.red,
          statusColor: Colors.red,
        ),
        const SizedBox(height: 16),
        const _DateLabel(date: '13 April, 2025'),
        const _TransactionCard(
          icon: Icons.arrow_outward_rounded,
          title: 'Order (stop-limit)',
          time: '2:30 PM',
          txId: 'SKY12345',
          status: 'Active',
          amount: '-100.00 USDT',
          amountColor: Colors.red,
          statusColor: Colors.blue,
        ),
        const _TransactionCard(
          icon: Icons.arrow_outward_rounded,
          title: 'Sent',
          time: '2:30 PM',
          txId: 'SKY12345',
          status: 'Completed',
          amount: '-100.00 USDT',
          amountColor: Colors.red,
          statusColor: Colors.green,
        ),
        const _TransactionCard(
          icon: Icons.call_received,
          title: 'Received',
          time: '2:30 PM',
          txId: 'SKY12345',
          status: 'Completed',
          amount: '+0.00113888 BTC',
          amountColor: Colors.green,
          statusColor: Colors.green,
        ),
        const _TransactionCard(
          icon: Icons.call_received,
          title: 'Sent',
          time: '2:30 PM',
          txId: 'SKY12345',
          status: 'Failed',
          amount: '0.00113888 BTC',
          amountColor: Colors.red,
          statusColor: Colors.red,
        ),
      ],
    );
  }
}

class _DateLabel extends StatelessWidget {
  final String date;
  const _DateLabel({required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        date,
        style: AppTextStyle.body14Regular
            .copyWith(color: AppTheme.blacktextColor(context)),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final String txId;
  final String status;
  final String amount;
  final Color amountColor;
  final Color statusColor;

  const _TransactionCard({
    required this.icon,
    required this.title,
    required this.time,
    required this.txId,
    required this.status,
    required this.amount,
    required this.amountColor,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.trasactionDetailsScreen);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[800],
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.body16Medium),
                  const SizedBox(height: 4),
                  Text('TI:$txId · $time', style: AppTextStyle.body14Regular),
                  Text(status,
                      style: AppTextStyle.body14Regular
                          .copyWith(color: statusColor)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(amount,
                style: AppTextStyle.body16Medium.copyWith(color: amountColor)),
          ],
        ),
      ),
    );
  }
}
