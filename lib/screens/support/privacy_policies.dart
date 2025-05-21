import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class PrivacyPolicies extends StatelessWidget {
  const PrivacyPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Privacy Policies'),
    );
  }
}
