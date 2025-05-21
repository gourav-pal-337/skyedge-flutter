import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textStyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      'question': 'What is SkyEdge Token (SKT)?',
      'answer':
          'SKT is the native utility token used for transactions, rewards, and data operations within the SkyEdge ecosystem.'
    },
    {
      'question': 'How do I earn tokens?',
      'answer':
          'You can earn tokens by participating in various platform activities.'
    },
    {
      'question': 'How do I connect my MetaMask wallet?',
      'answer': 'Go to Wallet > Connect > Select MetaMask and follow the steps.'
    },
    {
      'question': 'What is Data Intelligence?',
      'answer':
          'It’s the analysis and processing of collected data to derive insights.'
    },
    {
      'question': 'Can I withdraw my tokens?',
      'answer': 'Yes, tokens can be withdrawn to any supported wallet.'
    },
    {
      'question': 'What happens when someone buys my dataset?',
      'answer': 'You receive tokens as payment directly to your linked wallet.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'FAQs'),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and title

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  final item = faqs[index];
                  final isExpanded = expandedIndex == index;

                  return ExpansionTile(
                    title: Text(item['question']!,
                        style: AppTextStyle.body16Medium),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4),
                        child: Text(item['answer']!,
                            style: AppTextStyle.body14Medium),
                      ),
                      // Divider(color: Colors.grey.shade800),
                    ],
                    onExpansionChanged: (isExpanded) => setState(() {
                      expandedIndex = isExpanded ? null : index;
                    }),
                    trailing: Icon(
                      isExpanded
                          ? Icons.remove_circle_outline
                          : Icons.add_circle_outline,
                      color: AppTheme.greenTextColor(context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
