import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/wallet/widgets/monetization_tab.dart';
import 'package:skyedge/screens/wallet/widgets/trasection_tab.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key});

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 3), () {
    _tabController = TabController(length: 2, vsync: this);
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MyAppBar(title: 'History'),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                // borderRadius: BorderRadius.circular(12),
                color: AppTheme.primaryColorLight,
              ),
              labelColor: Colors.black,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: AppTheme.blacktextColor(context),
              labelStyle: AppTextStyle.body14Medium600,
              unselectedLabelStyle: AppTextStyle.body14Regular,
              tabs: const [
                Tab(text: 'Transactions'),
                Tab(text: 'Monetization'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTransactionsTab(context),
                MonetizationScreen()
                // _buildMonetizationTab(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab(BuildContext context) {
    return Column(
      children: [
        Row(
          // spacing: 8,
          // runSpacing: 8,
          children: ['All', 'Sell', 'Buy', 'Transfer', 'Order']
              .map((label) =>
                  _FilterChip(label: label, selected: label == 'All'))
              .toList(),
        ),
        const SizedBox(height: 16),
        Expanded(child: TransactionHistoryScreen())
      ],
    );
  }

  Widget _buildMonetizationTab(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardBackgroundColor(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/7/75/Zomato_logo.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Zomato', style: AppTextStyle.subtitle18Bold),
                    const SizedBox(height: 4),
                    Text('March 15, 2025, 2:30 PM',
                        style: AppTextStyle.body14Regular),
                    Text('Data Shared: Food Order History',
                        style: AppTextStyle.body14Regular),
                    Text('Pay Out: March 2, 2025',
                        style: AppTextStyle.body14Regular),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('45.2 \$SKYE',
                      style: AppTextStyle.subtitle18Medium
                          .copyWith(color: AppTheme.primaryColorLight)),
                  const SizedBox(height: 4),
                  Text(index == 1 ? 'Resume' : 'Stop Sharing',
                      style: AppTextStyle.body14Medium.copyWith(
                          color: index == 1 ? Colors.green : Colors.redAccent)),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: selected ? AppTheme.primaryColorLight : Colors.transparent),
        color: selected
            ? AppTheme.primaryColorLight.withOpacity(0.2)
            : Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Text(
        label,
        style: AppTextStyle.body14Medium.copyWith(
          color: AppTheme.blacktextColor(context),
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String type;
  final String amount;
  final String time;
  final String status;
  final bool isIncoming;
  final Color color;

  const _TransactionItem({
    required this.type,
    required this.amount,
    required this.time,
    required this.status,
    required this.isIncoming,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.grey[800],
        child: Icon(
          isIncoming ? Icons.arrow_downward : Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
      title: Text(type, style: AppTextStyle.body16Medium),
      subtitle: Text('TI:SKY12345 · $time\n$status',
          style: AppTextStyle.body14Regular),
      trailing: Text(
        amount,
        style: AppTextStyle.body16Medium.copyWith(color: color),
      ),
    );
  }
}

// class WalletHistoryScreen extends StatelessWidget {
//   const WalletHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(title: 'History'),
//       body: const Center(child: Text('Wallet History')),
//     );
//   }
// }
