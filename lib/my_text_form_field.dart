import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';

enum InputType { text, dropdown }

// class MyTextFormField extends StatefulWidget {
//   final InputType? inputType;
//   final TextEditingController? textController;
//   final String? hintText;
//   final String? label;
//   final FormFieldValidator<String>? validator;
//   final void Function(String?)? onSaved;
//   final void Function(String?)? onChanged;
//   final void Function()? onTap;

//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType? keyboardType;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool? obscureText;
//   final int? maxLines;
//   final double? fieldHeight;
//   final bool readOnly;
//   final List? options;
//   final String? initialValue;
//   final TextCapitalization? textCapitalization;
//   final TextAlign? textAlign;
//   final Color backgroundColor;
//   final Color? textColor;
//   final bool showBorder;

//   const MyTextFormField({
//     super.key,
//     this.inputType = InputType.text,
//     this.textController,
//     this.hintText,
//     this.label,
//     this.validator,
//     this.onSaved,
//     this.onTap,
//     this.onChanged,
//     this.inputFormatters,
//     this.keyboardType,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.obscureText,
//     this.maxLines = 1,
//     this.readOnly = false,
//     this.options,
//     this.initialValue,
//     this.fieldHeight = 56,
//     this.textCapitalization = TextCapitalization.sentences,
//     this.textAlign,
//     this.backgroundColor = Colors.white,
//     this.textColor,
//     this.showBorder = true,
//   });

//   @override
//   State<MyTextFormField> createState() => _MyTextFormFieldState();
// }

// class AppColors {}

// class _MyTextFormFieldState extends State<MyTextFormField> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.fieldHeight,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: widget.backgroundColor,
//         border: widget.showBorder == true
//             ? Border.all(color: AppTheme.grey!)
//             : null,
//       ),
//       child: widget.inputType == InputType.text
//           ? Row(
//               children: [
//                 widget.prefixIcon ?? const SizedBox(),
//                 Expanded(
//                   child: TextFormField(
//                     onTapOutside: (event) {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                       // FocusScope.of(context).unfocus();
//                     },
//                     textAlign: widget.textAlign ?? TextAlign.start,
//                     onTap: widget.onTap,
//                     controller: widget.textController,
//                     initialValue: widget.initialValue,
//                     textCapitalization: widget.textCapitalization!,
//                     readOnly: widget.readOnly,
//                     style: AppTextStyle.body16Regular,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(vertical: 5),
//                       errorStyle: AppTextStyle.body16Regular.copyWith(
//                         fontSize: 10,
//                       ),

//                       // alignLabelWithHint: true,
//                       floatingLabelAlignment: FloatingLabelAlignment.start,
//                       floatingLabelBehavior: FloatingLabelBehavior.auto,
//                       errorMaxLines: 2,
//                       // focusedBorder: InputBorder.none,
//                       border: InputBorder.none,
//                       hintText: widget.hintText ?? "",
//                       errorBorder: InputBorder.none,
//                       label: widget.label == null ? null : Text(widget.label!),
//                       hintStyle: AppTextStyle.body16Regular.copyWith(
//                         color: widget.textColor,
//                       ),
//                     ),
//                     obscureText: widget.obscureText ?? false,
//                     keyboardType: widget.keyboardType,
//                     maxLines: widget.maxLines,
//                     validator: widget.validator,
//                     onSaved: widget.onSaved,
//                     onChanged: widget.onChanged,
//                     inputFormatters: widget.inputFormatters,
//                   ),
//                 ),
//                 widget.suffixIcon ?? const SizedBox(),
//               ],
//             )
//           : Container(
//               width: double.infinity,
//               margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
//               // padding: const EdgeInsets.symmetric(horizontal: 15),

//               child: Row(
//                 children: [
//                   // prefixIcon ?? const SizedBox(),
//                   Expanded(
//                     child: DropdownButtonFormField<String>(
//                         // isDense: true,
//                         value: widget.initialValue == ""
//                             ? null
//                             : widget.initialValue,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Colors.black,
//                         ),
//                         icon: widget.prefixIcon,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           // contentPadding: EdgeInsets.only(left: 0),
//                         ),
//                         onChanged:
//                             widget.onChanged ?? widget.onSaved ?? (value) {},
//                         alignment: Alignment.centerLeft,
//                         validator: widget.validator ??
//                             (value) {
//                               return null;
//                             },
//                         hint: Text(
//                           widget.hintText ?? '',
//                           style: AppTextStyle.body16Regular,
//                         ),
//                         items: widget.options!
//                             .map<DropdownMenuItem<String>>((item) {
//                           return DropdownMenuItem<String>(
//                             value: item,
//                             child: FittedBox(
//                               child: Text(
//                                 item,
//                                 textAlign: TextAlign.end,
//                                 style: AppTextStyle.body16Regular,
//                               ),
//                             ),
//                           );
//                         }).toList()),
//                   )
//                 ],
//               ),
//             ),
//       //  Column(
//       //   children: [
//       //     if (widget.inputType == InputType.text)
//       //       Row(
//       //         children: [
//       //           widget.prefixIcon ?? const SizedBox(),
//       //           Expanded(
//       //             child: TextFormField(
//       //               controller: widget.textController,
//       //               initialValue: widget.initialValue,
//       //               textCapitalization: widget.textCapitalization!,
//       //               style: AppTextStyle.textMdReg,
//       //               decoration: InputDecoration(
//       //                   contentPadding: const EdgeInsets.all(0),
//       //                   errorStyle: AppTextStyle.textXsReg
//       //                       .copyWith(fontSize: 10, ),
//       //                   errorMaxLines: 2,
//       //                   // focusedBorder: InputBorder.none,

//       //                   border: InputBorder.none,
//       //                   hintText: widget.hintText ?? "",
//       //                   errorBorder: InputBorder.none,
//       //                   label:
//       //                       widget.label == null ? null : Text(widget.label!),
//       //                   hintStyle: AppTextStyle.textMdReg),
//       //               obscureText: widget.obscureText ?? false,
//       //               keyboardType: widget.keyboardType,
//       //               maxLines: widget.maxLines,
//       //               validator: widget.validator,
//       //               onSaved: widget.onSaved,
//       //               onChanged: widget.onChanged,
//       //               inputFormatters: widget.inputFormatters,
//       //             ),
//       //           ),
//       //           widget.suffixIcon ?? const SizedBox(),
//       //         ],
//       //       ),
//       //     if (widget.inputType == InputType.dropdown)
//       //       Container(
//       //         width: double.infinity,
//       //         margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
//       //         // padding: const EdgeInsets.symmetric(horizontal: 15),

//       //         child: Row(
//       //           children: [
//       //             // prefixIcon ?? const SizedBox(),
//       //             Expanded(
//       //               child: DropdownButtonFormField<String>(
//       //                   // isDense: true,
//       //                   value: widget.initialValue == ""
//       //                       ? null
//       //                       : widget.initialValue,
//       //                   style: const TextStyle(
//       //                     fontSize: 13,
//       //                     color: Colors.black,
//       //                   ),
//       //                   icon: widget.prefixIcon,
//       //                   decoration: const InputDecoration(
//       //                     border: InputBorder.none,
//       //                     contentPadding: EdgeInsets.only(left: 10),
//       //                   ),
//       //                   onChanged:
//       //                       widget.onChanged ?? widget.onSaved ?? (value) {},
//       //                   alignment: Alignment.centerLeft,
//       //                   validator: widget.validator ?? (value) {},
//       //                   hint: Text(
//       //                     widget.hintText ?? '',
//       //                     style: const TextStyle(fontSize: 14),
//       //                   ),
//       //                   items: widget.options!
//       //                       .map<DropdownMenuItem<String>>((item) {
//       //                     return DropdownMenuItem<String>(
//       //                       value: item,
//       //                       child: FittedBox(
//       //                         child: Text(
//       //                           item,
//       //                           textAlign: TextAlign.end,
//       //                         ),
//       //                       ),
//       //                     );
//       //                   }).toList()),
//       //             )
//       //           ],
//       //         ),
//       //       ),
//       //   ],
//       // ),
//     );
//   }
// }

class MyTextFormField extends StatelessWidget {
  final String? label;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final IconData? suffixicon;
  final Widget? suffixWidget;

  final String? initialValue;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  const MyTextFormField({
    Key? key,
    this.label,
    required this.hintText,
    this.prefixIcon,
    this.prefixWidget,
    this.initialValue,
    this.suffixicon,
    this.suffixWidget,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label ?? '', style: AppTextStyle.body14Medium600),
          const SizedBox(height: 8)
        ],
        TextFormField(
          initialValue: initialValue,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixWidget ??
                (prefixIcon == null
                    ? null
                    : Icon(prefixIcon,
                        color: isDark ? Colors.white54 : Colors.black54)),
            suffixIcon: suffixWidget ??
                (suffixicon == null
                    ? null
                    : Icon(suffixicon,
                        color: isDark ? Colors.white54 : Colors.black54)),
            hintStyle: AppTextStyle.body14Regular.copyWith(
              color: isDark ? Colors.white60 : Colors.black54,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? Colors.white24 : Colors.black26,
              ),
            ),
            errorStyle: AppTextStyle.caption12Small.copyWith(
              color:
                  isDark ? AppTheme.errorColorDark : AppTheme.errorColorLight,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? Colors.white24 : Colors.black26,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white24
                    : Colors.black26, //Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
