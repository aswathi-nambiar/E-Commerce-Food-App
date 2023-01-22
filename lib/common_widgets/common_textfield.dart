import 'package:flutter/cupertino.dart';

/// [CommonTextField] is a common text field which returns [CupertinoTextFormFieldRow]

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {Key? key,
      this.icon,
      this.boxDecoration,
      this.textInputAction,
      this.obscureText = false,
      this.placeHolderStyle,
      this.validator,
      this.onChanged,
      this.hintText,
      this.initialValue,
      required this.textController,
      this.keyBoardType})
      : super(key: key);
  final BoxDecoration? boxDecoration;
  final FormFieldValidator? validator;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final TextEditingController textController;
  final TextStyle? placeHolderStyle;
  final bool obscureText;
  final Widget? icon;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      textInputAction: textInputAction,
      controller: textController,
      keyboardType: keyBoardType ?? TextInputType.text,
      prefix: icon,
      placeholder: hintText,
      placeholderStyle: placeHolderStyle,
      decoration: boxDecoration ??
          const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.inactiveGray,
              ),
            ),
          ),
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
