import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/models/user_model.dart';
import 'package:skyedge/providers/auth_provider.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/utils/extensions/string_extensions.dart';
import 'package:skyedge/utils/input_validator.dart';
import 'package:skyedge/widgets/my_appbar.dart';
import 'package:skyedge/widgets/my_text_form_field.dart';
import 'package:skyedge/widgets/submit_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  bool conditionAccepted = false;
  bool loading = false;

  void validate() async {
    final authProv = Provider.of<AuthProvider>(context, listen: false);

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loading = true;
      setState(() {});
      try {
        await authProv.sendOtp(
            isLoginReq: false,
            phoneNumber: authProv.userModel.phoneNumber!,
            onCodeSent: (value) {
              context.push(AppRoutes.otpVerificationScreen);
            },
            onFailed: (value) {
              "unable to send otp".toast();
            },
            onAutoVerified: (value) {},
            onCodeAutoRetrievalTimeout: () {});
      } catch (e) {
        "Unable to send otp, please try again later".toast();
      } finally {
        loading = false;
        setState(() {});
      }
      debugPrint('user model : ${authProv.userModel.toJson()}');
      // setState(() {});
      // context.push(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: MyAppBar(
        title: 'Registration',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create account!",
                  style: AppTextStyle.subtitle18Bold,
                ),
                10.verticalSpace,
                Text(
                  "Please provide the following information to get started",
                  style: AppTextStyle.body14Regular
                      .copyWith(color: AppTheme.greyText),
                ),
                20.verticalSpace,
                MyTextFormField(
                  label: "Name",
                  hintText: "Enter your name",
                  prefixIcon: Icons.person,
                  onSaved: (value) {
                    authProv.userModel.fullname = value;
                    authProv.updateUserModel(authProv.userModel);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    if (value.length < 3) {
                      return "Name should be at least 3 characters long";
                    }
                  },
                ),
                18.verticalSpace,
                MyTextFormField(
                  label: "Username",
                  hintText: "Enter your username",
                  prefixIcon: Icons.person,
                  onSaved: (value) {
                    authProv.userModel.username = value;
                    authProv.updateUserModel(authProv.userModel);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your username";
                    }
                    if (value.length < 6) {
                      return "Username should be at least 6 characters long";
                    }
                  },
                ),
                18.verticalSpace,
                MyTextFormField(
                  label: "Email",
                  hintText: "Enter your Email",
                  prefixIcon: Icons.email,
                  onSaved: (value) {
                    authProv.userModel.email = value;
                    authProv.updateUserModel(authProv.userModel);
                  },
                  validator: (value) {
                    return Validators.validateEmail(value, true);
                  },
                ),
                18.verticalSpace,
                MyTextFormField(
                  label: "Mobile Number",
                  hintText: "Mobile Number",
                  onSaved: (value) {
                    authProv.userModel.phoneNumber =
                        "${authProv.countrycode}$value";
                    authProv.updateUserModel(authProv.userModel);
                  },
                  prefixWidget: GestureDetector(
                    onTap: () async {
                      final code = await showCountryCodePickerSheet(
                        context: context,
                        onCountryCodeTap: (code) {
                          Navigator.pop(context, code);
                        },
                      );

                      authProv.updateCountryCode(code?.dialCode, code?.flag);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            authProv.countryFlag,
                            style: const TextStyle(fontSize: 23),
                          ),
                          const SizedBox(width: 5),
                          Text(authProv.countrycode.toString()),
                          const Icon(
                            CupertinoIcons.chevron_down,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  validator: (value) {
                    return Validators.phoneNumberValidator(value);
                  },
                ),
                10.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: conditionAccepted,
                      onChanged: (value) {
                        setState(() {
                          conditionAccepted = value!;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5),
                        child: RichText(
                          text: TextSpan(
                              text:
                                  "I confirm the details provided are accurate and agree to the",
                              style: AppTextStyle.caption12Small.copyWith(
                                color: AppTheme.greyText,
                              ),
                              children: [
                                TextSpan(
                                  text: "  Terms & Conditions",
                                  style: AppTextStyle.caption12Small
                                      .copyWith(color: AppTheme.blue),
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        onTap: () {
          validate();
        },
        loading: loading,
        isAtBottom: true,
        // tapable: ,
        label: "Signup",
      ),
    );
  }
}
