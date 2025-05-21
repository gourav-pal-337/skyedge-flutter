import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textStyle.dart';
import 'package:skyedge/custom_popup.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class BankStatementsScreen extends StatefulWidget {
  const BankStatementsScreen({super.key});

  @override
  State<BankStatementsScreen> createState() => _BankStatementsScreenState();
}

class _BankStatementsScreenState extends State<BankStatementsScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> transactions = [
    {
      "date": "01/03/2025",
      "customer": "Mr. Rajat Verma",
      "city": "NaN",
      "description": "NEFT: Rent to A. Mehra 932347234\n15,000.00",
      "type": "NEFT Transfer"
    },
    {
      "date": "01/03/2025",
      "customer": "Mr. Rajat Verma",
      "city": "NaN",
      "description": "ATM Withdrawal - Hauz Khas Branch 202348473...\n5,000.00",
      "type": "ATM Withdrawal"
    },
    {
      "date": "05/03/2025",
      "customer": "Mr. Rajat Verma",
      "city": "NaN",
      "description": "Salary Credit - TCS Ltd. SALMAR0423\n60,000.00",
      "type": "Other"
    },
    {
      "date": "08/03/2025",
      "customer": "Mr. Rajat Verma",
      "city": "NaN",
      "description": "UPI: Amazon IN UPI8431342\n1,499.00",
      "type": "UPI Payment"
    },
    {
      "date": "10/03/2025",
      "customer": "Mr. Rajat Verma",
      "city": "NaN",
      "description": "UPI: Zomato Order UPI9021345\n650.00",
      "type": "UPI Payment"
    },
    {
      "date": "14/03/2025",
      "customer": "Mr. Rajat Verma",
      "city": "NaN",
      "description": "IMPS to Jatin Arora IMPS234809\n10,000.00",
      "type": "IMPS Transfer"
    },
    {
      "date": "18/03/2025",
      "customer": "Mr. Rajat Verma",
      "city": "NaN",
      "description": "Interest Credit - SBI AUTOCRDT\n1,500.00",
      "type": "Interest Credit"
    },
    {
      "date": "22/03/2025",
      "customer": "Mr. Rajat Verma",
      "city": "NaN",
      "description": "Insurance Premium - HDFC Life INS345677\n2,401.00",
      "type": "Insurance Payment"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MyAppBar(title: 'Bank Statements'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackgroundColor(context),
                  // borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Bank statements",
                            style: AppTextStyle.body16Medium
                                .copyWith(fontWeight: FontWeight.bold)),
                        Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Row",
                            style: AppTextStyle.button12
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("2.5 MB  •  Mar 15, 2025",
                        style: AppTextStyle.button12
                            .copyWith(color: AppTheme.greyText)),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Monthly billing statement (PDF)",
                            style: AppTextStyle.button12),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return Dialog(
                                    child: MyCustomPopup(
                                      title:
                                          "Are you sure you want to delete this dataset?",
                                      description:
                                          "This action cannot be undone. The selected dataset will be permanently removed from your dashboard.",
                                      confirmText: "Delete",
                                      goBackText: "Cancel",
                                    ),
                                  );
                                });
                          },
                          child: Text("Delete",
                              style: TextStyle(color: Colors.redAccent)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackgroundColor(context),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade800),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Customer")),
                      DataColumn(label: Text("City")),
                      DataColumn(label: Text("Description")),
                      DataColumn(label: Text("Transaction Type")),
                    ],
                    rows: transactions.map((tx) {
                      return DataRow(cells: [
                        DataCell(Text(tx['date']!)),
                        DataCell(Text(tx['customer']!)),
                        DataCell(Text(tx['city']!)),
                        DataCell(Text(tx['description']!)),
                        DataCell(Text(tx['type']!)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
