import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/my_appbar.dart';
import 'package:skyedge/providers/wallet_provider.dart';
import 'package:skyedge/screens/wallet/sell/widgets/advaced_tab.dart';
import 'package:skyedge/screens/wallet/sell/widgets/simple_tab.dart';
import 'package:skyedge/submit_button.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

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
    final walletProv = context.watch<WalletProvider>();
    bool isBuying = walletProv.isBuying;
    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: MyAppBar(
        title: isBuying ? 'Buy' : 'Sell',
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          const Text(
            'Current Value',
            style: AppTextStyle.body16Regular,
          ),
          const SizedBox(height: 4),
          Text(
            '1 Token = 2.4 USDT',
            style: AppTextStyle.title24MediumClash
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const Text(
            '+2.60%',
            style: AppTextStyle.body16Medium,
          ),
          const SizedBox(height: 16),
          _buildGraphSection(context),
          const SizedBox(height: 16),
          _buildTabSwitcher(
            context,
            _tabController,
            onTap: (p0) {
              _tabController.index = p0;
              _selectedIndex = p0;
              setState(() {});
            },
          ),
          25.verticalSpace,
          _selectedIndex == 0 ? SimpleTab() : AdvancedTab(),
        ],
      ),
      bottomNavigationBar: SubmitButton(
          onTap: () {
            if (_selectedIndex == 0) {
              context.push(AppRoutes.connectWalletScreen);
            } else {
              context.push(AppRoutes.previewOrderScreen);
            }
          },
          isAtBottom: true,
          label: _selectedIndex == 1
              ? "Place order"
              : isBuying
                  ? "Continue to Buy"
                  : "Continue to sell"),
    );
  }

  Widget _buildGraphSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
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
              decoration: BoxDecoration(),
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
                      color: AppTheme.blue,
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
                            AppTheme.blue.withOpacity(0.6),
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

Widget _buildTabSwitcher(BuildContext context, TabController _tabController,
    {void Function(int)? onTap}) {
  return Container(
    // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).colorScheme.surfaceVariant,
    ),
    child: TabBar(
      controller: _tabController,
      onTap: onTap,
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
        Tab(text: 'Simple'),
        Tab(text: 'Advanced'),
      ],
    ),
  );
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
