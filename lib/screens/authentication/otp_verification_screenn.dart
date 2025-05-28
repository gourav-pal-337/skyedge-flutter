import 'dart:async';

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
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final formKey = GlobalKey<FormState>();
  bool conditionAccepted = false;
  final pinController = TextEditingController();
  int _start = 120;
  final focusNode = FocusNode();
  bool _canResend = false;

  late Timer _timer;
  bool loading = false;

  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void validate() async {
    final authProv = Provider.of<AuthProvider>(context, listen: false);

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loading = true;
      setState(() {});
      try {
        await authProv
            .verifyOtp(
          otpCode: pinController.text,
        )
            .then((value) async {
          debugPrint(
              'user model : ${value?.user?.uid} : ${value?.credential?.asMap()}');
          authProv.userModel.id = value?.user?.uid ?? '';
          authProv.updateUserModel(authProv.userModel);
          if (authProv.isLoginRequest) {
            await authProv.loginUser();
          } else {
            await authProv.createUser();
          }
          context.go(
            AppRoutes.questionnaireWelcomeScreen,
          );
        });
      } catch (e) {
        "Invalid otp, please try again later".toast();
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

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: AppTheme.blacktextColor(context),
      ),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.grey!),
      ),
    );

    return Scaffold(
      appBar: const MyAppBar(
        title: 'OTP',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Text(
                  "Enter the 4-digit that we have sent via the phone number +${authProv.countrycode} ${authProv.userModel.phoneNumber}",
                  style: AppTextStyle.body14Regular
                      .copyWith(color: AppTheme.greyText),
                ),
                20.verticalSpace,
                Pinput(
                  controller: pinController,
                  // focusNode: focusNode,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    // signupProvider.otp = pin;
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                    setState(() {});
                  },

                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: AppTheme.greyText,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      // borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.greyText!),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: AppTheme.greyText?.withOpacity(0.3),
                      // borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.greyText!),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
                // MyTextFormField(
                //   label: "Mobile Number",
                //   hintText: "Mobile Number",
                //   prefixWidget: GestureDetector(
                //     onTap: () async {
                //       final code = await showCountryCodePickerSheet(
                //         context: context,
                //         onCountryCodeTap: (code) {
                //           Navigator.pop(context, code);
                //         },
                //       );

                //       authProv.updateCountryCode(code?.dialCode, code?.flag);
                //     },
                //     child: Container(
                //       height: 40,
                //       width: 100,
                //       color: Colors.transparent,
                //       padding: const EdgeInsets.symmetric(horizontal: 4),
                //       alignment: Alignment.centerLeft,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             authProv.countryFlag,
                //             style: const TextStyle(fontSize: 23),
                //           ),
                //           const SizedBox(width: 5),
                //           Text(authProv.countrycode.toString()),
                //           const Icon(
                //             CupertinoIcons.chevron_down,
                //             size: 15,
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                //   validator: (value) {
                //     return Validators.phoneNumberValidator(value);
                //   },
                // ),
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
                Text(
                  "This session will end in ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')} minutes.",
                  style: TextStyle(color: AppTheme.greyText),
                ),
                InkWell(
                  onTap: _canResend
                      ? () {
                          setState(() {
                            _canResend = false;
                            _start = 120;
                            pinController.text = "";
                          });
                          startTimer();
                          // signupProvider.resendOtp();
                          // Trigger the resend OTP functionality here
                        }
                      : null,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: 'Didn’t receive any code? ',
                      style: TextStyle(
                        color: AppTheme.greyText,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 17.97 / 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Resend code',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color:
                                _canResend ? AppTheme.blue : AppTheme.greyText,
                            height: 17.97 / 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                SubmitButton(
                  onTap: () {
                    validate();
                    // context.push(AppRoutes.questionnaireWelcomeScreen);
                  },
                  loading: loading,
                  tapable: pinController.text.length == 6,
                  label: "Verify",
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
