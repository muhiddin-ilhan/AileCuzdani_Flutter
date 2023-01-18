import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_constants.dart';

Widget customTextbox(
  BuildContext ctx, {
  Color? textColor,
  Icon? prefixIcon,
  Widget? suffixIcon,
  String? labelText,
  String? errorText,
  bool? obsecureText,
  Function(String text)? onChanged,
  TextEditingController? controller,
  double? borderRadius,
  BorderRadius? borderRadiusEdge,
  double? contentPadding,
  double? contentPaddingHorizontal,
  TextAlign? textAlign,
  TextAlignVertical? textAlignVertical,
  EdgeInsets? contentPaddingEdge,
  double? fontSize,
  double? elevation,
  TextInputAction? textInputAction,
  Function(String value)? onFieldSubmitted,
  TextInputFormatter? textMask,
  TextInputType? inputType,
  bool? enabled,
  double? height,
  FocusNode? focusNode,
  String? hintText,
  int? maxLength,
  bool isMultiline = false,
  bool isNumber = false,
  bool isMinusNumber = true,
  bool enableSuggestion = true,
  bool autoCorrect = true,
  double minWidthPrefix = 60,
  bool isCurrency = false,
  Color? color,
  bool isBorder = true,
  bool isCapitalizeSentence = false,
}) {
  return Material(
    borderRadius: borderRadiusEdge ??
        BorderRadius.all(
          Radius.circular(borderRadius ?? 0),
        ),
    color: color,
    elevation: elevation ?? 0,
    child: Theme(
      data: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: CustomColors.GREEN),
      ),
      child: SizedBox(
        height: height ?? 50,
        child: TextField(
          textCapitalization: isCapitalizeSentence ? TextCapitalization.sentences : TextCapitalization.none,
          textInputAction: textInputAction ?? TextInputAction.done,
          textAlign: textAlign ?? TextAlign.start,
          textAlignVertical: isMultiline ? TextAlignVertical.top : TextAlignVertical.center,
          keyboardType: inputType ?? TextInputType.text,
          obscureText: obsecureText ?? false,
          inputFormatters: isNumber
              ? isMinusNumber
                  ? [FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)$'))]
                  : [FilteringTextInputFormatter.digitsOnly]
              : null,
          enabled: enabled ?? true,
          focusNode: focusNode,
          minLines: isMultiline ? 1 : null,
          maxLength: maxLength,
          enableSuggestions: enableSuggestion,
          maxLines: isMultiline ? null : 1,
          autocorrect: autoCorrect,
          decoration: InputDecoration(
            contentPadding: contentPaddingEdge ?? EdgeInsets.symmetric(vertical: contentPadding ?? 0, horizontal: contentPaddingHorizontal ?? 0),
            border: OutlineInputBorder(
              borderRadius: borderRadiusEdge ?? BorderRadius.all(Radius.circular(borderRadius ?? 0)),
              borderSide: BorderSide(width: isBorder ? 1 : 0),
            ),
            errorText: errorText,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            counterText: "",
            prefixIcon: prefixIcon,
            prefixIconConstraints: BoxConstraints(minWidth: minWidthPrefix, minHeight: height ?? 50),
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(minWidth: minWidthPrefix, minHeight: height ?? 50),
            labelText: labelText,
            hintText: hintText,
            disabledBorder: OutlineInputBorder(
              borderRadius: borderRadiusEdge ?? BorderRadius.all(Radius.circular(borderRadius ?? 0)),
              borderSide: BorderSide(color: Colors.black.withOpacity(0.35)),
            ),
          ),
          style: TextStyle(color: textColor ?? Colors.black, fontSize: fontSize ?? 18),
          onChanged: onChanged,
          controller: controller,
          onSubmitted: onFieldSubmitted,
        ),
      ),
    ),
  );
}
