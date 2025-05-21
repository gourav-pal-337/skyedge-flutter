import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: MyAppBar(title: "Order History"),
      // AppBar(
      //   backgroundColor: theme.colorScheme.background,
      //   leading: const BackButton(),
      //   title: Text(
      //     "Order History",
      //     style: AppTextStyle.clashDisplay.bold.copyWith(fontSize: 20),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFilterChips(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildOrderCard(
                    context,
                    status: index == 0 ? "Active" : "Completed",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ["All", "Active", "Completed", "Cancelled"];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ['All', 'Sell', 'Buy', 'Transfer', 'Order']
          .map((label) => _FilterChip(label: label, selected: label == 'All'))
          .toList(),
    );
  }

  Widget _buildOrderCard(BuildContext context, {required String status}) {
    final theme = Theme.of(context);
    final isActive = status == "Active";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("ORD-2025-01230-4156", style: AppTextStyle.body14Regular),
              const Spacer(),
              Text("March 23, 2023",
                  style: AppTextStyle.body14Regular.copyWith(
                    color: AppTheme.greyText,
                  )),
            ],
          ),
          const Divider(color: Colors.grey, height: 24),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text("BTC/USDT", style: AppTextStyle.body16Medium),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Limit",
                        style: AppTextStyle.caption12Regular
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Expanded(
                child: Text(
                  status,
                  style: AppTextStyle.body16Medium.copyWith(
                    fontSize: 14,
                    color: isActive
                        ? AppTheme.blue
                        : AppTheme.greenTextColor(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _infoColumn("Quantity", "0.0234"),
              _infoColumn("Total Value", "\$23456"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _infoColumn("Price", "\$42156.78"),
              _infoColumn("Fee", "\$0.98"),
            ],
          ),
          if (isActive)
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              alignment: Alignment.bottomCenter,
              child: Text(
                "Cancel Order",
                style: AppTextStyle.body14Medium.copyWith(
                  color: Colors.redAccent,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.caption12Regular),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyle.body16Regular),
        ],
      ),
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
