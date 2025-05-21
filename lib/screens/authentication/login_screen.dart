import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:canopas_country_picker/canopas_country_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/providers/auth_provider.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/utils/extensions/string_extensions.dart';
import 'package:skyedge/utils/input_validator.dart';
import 'package:skyedge/widgets/my_appbar.dart';
import 'package:skyedge/widgets/my_text_form_field.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            isLoginReq: true,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: MyAppBar(
        title: 'Login',
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
                  "Welcome Back to Skyedge!",
                  style: AppTextStyle.subtitle18Bold,
                ),
                10.verticalSpace,
                Text(
                  "Securely access your account and take control of your data and digital assets.",
                  style: AppTextStyle.body14Regular
                      .copyWith(color: AppTheme.greyText),
                ),
                20.verticalSpace,
                MyTextFormField(
                  label: "Mobile Number",
                  hintText: "Mobile Number",
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
                  onSaved: (value) {
                    authProv.userModel.phoneNumber =
                        "${authProv.countrycode}$value";
                    authProv.updateUserModel(authProv.userModel);
                  },
                  validator: (value) {
                    return Validators.phoneNumberValidator(value);
                  },
                ),
                10.verticalSpace,
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Checkbox(
                //       value: conditionAccepted,
                //       onChanged: (value) {
                //         setState(() {
                //           conditionAccepted = value!;
                //         });
                //       },
                //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //     ),
                //     Expanded(
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 5.0, vertical: 5),
                //         child: RichText(
                //           text: TextSpan(
                //               text:
                //                   "I confirm the details provided are accurate and agree to the",
                //               style: AppTextStyle.caption12Small.copyWith(
                //                 color: AppTheme.greyText,
                //               ),
                //               children: [
                //                 TextSpan(
                //                   text: "  Terms & Conditions",
                //                   style: AppTextStyle.caption12Small
                //                       .copyWith(color: AppTheme.blue),
                //                 )
                //               ]),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                10.verticalSpace,
                SubmitButton(
                  onTap: () {
                    validate();
                  },
                  loading: loading,

                  // tapable: ,
                  label: "Signup",
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Text("or continue with"),
                    ),
                    Expanded(child: Divider())
                  ],
                ),

                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppAssets.googleLogo,
                    AppAssets.fbLogo,
                    AppAssets.appleLogo
                  ].map((value) {
                    return Container(
                      height: 55,
                      width: 55,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          color: AppTheme.grey, shape: BoxShape.circle),
                      child: ShowImage(
                        imagelink: value,
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
