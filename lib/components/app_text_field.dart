import 'package:flutter/material.dart';
import 'package:state_management/utils/contants/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.textInputAction,
    required this.labelText,
    required this.keyboardType,
    required this.controller,
    super.key,
    this.onChanged,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.onEditingComplete,
    this.autofocus,
    this.focusNode,
    this.decoration,
  });

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String labelText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        autofocus: autofocus ?? false,
        validator: validator,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        onEditingComplete: onEditingComplete,
        decoration: decoration ??
            InputDecoration(
              suffixIcon: suffixIcon,
              labelText: labelText,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.black),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
