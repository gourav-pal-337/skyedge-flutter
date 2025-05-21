import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/providers/wallet_provider.dart';
import 'package:skyedge/screens/home/widgets/sky_token_card.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/router_util.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme.isDarkMode(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MyAppBar(title: 'My Wallet'),
      // AppBar(
      //   title: const Text('My Wallet'),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios_new),
      //     onPressed: () {},
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
            const SizedBox(height: 24),
            _buildGraphSection(context),
            const SizedBox(height: 24),
            _buildRecentTransactions(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final transactions = [
      {
        'type': 'Sent',
        'amount': '-0.0013388 BTC',
        'time': '2:30 PM',
        'color': Colors.red
      },
      {
        'type': 'Received',
        'amount': '+0.0011388 BTC',
        'time': '2:30 PM',
        'color': Colors.green
      },
      {
        'type': 'Received',
        'amount': '+0.0011388 BTC',
        'time': '2:30 PM',
        'color': Colors.green
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Transactions',
                style: Theme.of(context).textTheme.titleMedium),
            TextButton(
                onPressed: () {
                  context.push(AppRoutes.walletHistoryScreen);
                },
                child: const Text('See all')),
          ],
        ),
        const SizedBox(height: 8),
        ...transactions.map((tx) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: Icon(
                  tx['type'] == 'Sent'
                      ? Icons.arrow_outward_rounded
                      : Icons.call_received,
                  color: Colors.white,
                ),
              ),
              title: Text(tx['type'].toString(),
                  style: Theme.of(context).textTheme.bodyMedium),
              subtitle: Text('TI:SKY12345 · ${tx['time']!}',
                  style: Theme.of(context).textTheme.bodySmall),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tx['amount'].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: tx['color'] as Color),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'TI:SKY12345',
                    style: AppTextStyle.body14Medium
                        .copyWith(color: AppTheme.greyText),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return SizedBox(
      height: 200,
      child: SkyeTokenCard(),
    );
    // Container(
    //   padding: const EdgeInsets.all(20),
    //   decoration: BoxDecoration(
    //     color: AppTheme.cardBackgroundColor(context),
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         'SKYEDGE Tokens',
    //         style: Theme.of(context).textTheme.labelLarge,
    //       ),
    //       const SizedBox(height: 8),
    //       Text(
    //         '4,378.44SKYE',
    //         style: Theme.of(context).textTheme.headlineLarge?.copyWith(
    //               fontWeight: FontWeight.bold,
    //             ),
    //       ),
    //       const SizedBox(height: 4),
    //       Text(
    //         '= \$1299 USD',
    //         style: Theme.of(context).textTheme.bodyMedium,
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildActionButtons(BuildContext context) {
    final actions = [
      {
        'icon': Icons.call_received,
        'label': 'Buy',
        "route": AppRoutes.sellScreen
      },
      {
        'icon': Icons.call_made,
        'label': 'Sell',
        "route": AppRoutes.sellScreen,
      },
      {
        'icon': Icons.sync_alt,
        'label': 'Transfer',
        "route": AppRoutes.transeferScreen
      },
      {
        'icon': Icons.compare_arrows,
        'label': 'Convert',
        "route": AppRoutes.conversionScreen
      },
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions
          .map((action) => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      final walletProv = context.read<WalletProvider>();
                      if (action['route'] == null) return;
                      if (action['label'] == 'Buy') {
                        walletProv.isBuying = true;
                      } else if (action['label'] == 'Sell') {
                        walletProv.isBuying = false;
                      }
                      context.push(action['route'].toString());
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppTheme.primaryColorLight.withOpacity(0.05),
                      ),
                      child: Icon(action['icon'] as IconData,
                          color: AppTheme.primaryColorLight),
                    ),
                  ),
                  // CircleAvatar(
                  //   backgroundColor:
                  //       AppTheme.primaryColorLight.withOpacity(0.1),
                  //   child: Icon(action['icon'] as IconData,
                  //       color: AppTheme.primaryColorLight),
                  // ),
                  const SizedBox(height: 8),
                  Text(
                    action['label'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ))
          .toList(),
    );
  }

  Widget _buildGraphSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Token Price Graph',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () {},
              child: Text('See all',
                  style: Theme.of(context).textTheme.labelLarge),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Price alert: ',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '▼ 13%',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.redAccent),
            ),
            const SizedBox(width: 8),
            Text(
              'SKT 31.000',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.redAccent),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            _GraphTab(label: '1D', isSelected: true),
            _GraphTab(label: '1W'),
            _GraphTab(label: '1M'),
            _GraphTab(label: '1Y'),
          ],
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 21),
              height: 200,
              decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     AppTheme.primaryColorLight.withOpacity(0.15),
                  //     Colors.transparent,
                  //   ],
                  // ),
                  ),
            ),
            Container(
              // margin: EdgeInsets.only(),
              height: 200,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       AppTheme.primaryColorLight.withOpacity(0.15),
              //       Colors.transparent,
              //     ],
              //   ),
              // ),
              child: LineChart(
                LineChartData(
                  minY: 27,
                  maxY: 32,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const labels = [
                            '10:00',
                            '12:00',
                            '14:00',
                            '16:00',
                            '18:00'
                          ];
                          if (value % 2 == 0 && value ~/ 2 < labels.length) {
                            return Text(labels[value ~/ 2],
                                style: Theme.of(context).textTheme.bodySmall);
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          if (value % 1 == 0) {
                            return Text('${value.toInt()}k',
                                style: Theme.of(context).textTheme.bodySmall);
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 40,
                      ),
                    ),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: AppTheme.primaryColorLight,
                      dotData: FlDotData(
                        show: true,
                        checkToShowDot: (spot, _) => spot.x == 6,
                        // dotColor: AppTheme.primaryColorLight,
                        // dotSize: 8,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.primaryColorLight.withOpacity(0.3),
                            Colors.transparent
                          ],
                        ),
                      ),
                      spots: const [
                        FlSpot(0, 28),
                        FlSpot(1, 28.5),
                        FlSpot(2, 30.2),
                        FlSpot(3, 29.3),
                        FlSpot(4, 28.8),
                        FlSpot(5, 30.1),
                        FlSpot(6, 31),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _GraphTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _GraphTab({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.grey?.withOpacity(0.8)
            : AppTheme.grey?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.black,
            ),
      ),
    );
  }
}
