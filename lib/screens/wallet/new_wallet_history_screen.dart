import 'package:flutter/material.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class NewWalletHistoryScreen extends StatelessWidget {
  const NewWalletHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'History'),
      body: Column(
        children: [
          Text('History'),
        ],
      ),
    );
  }
}
