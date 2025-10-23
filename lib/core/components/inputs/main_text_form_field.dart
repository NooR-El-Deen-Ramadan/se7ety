// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:se7ety/core/utils/fonts.dart';

// ignore: must_be_immutable
class MainTextFormField extends StatefulWidget {
  MainTextFormField({
    super.key,
    required this.controller,
    this.textFormFieldText,
    this.maxTextLines = 1,
    this.validator,
    required this.ispassword,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
    this.inputFormatters,
  });
  bool ispassword = false;
  final Function()? onTap;
  final bool readOnly;
  final Widget? suffixIcon;
  String? Function(String?)? validator;
  int maxTextLines;
  String? textFormFieldText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<MainTextFormField> createState() => _MainTextFormFieldState();
}

class _MainTextFormFieldState extends State<MainTextFormField> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.ispassword && isObsecure,
      validator: widget.validator,
      controller: widget.controller,
      maxLines: widget.maxTextLines,
      style: AppFontStyles.title,
      decoration: InputDecoration(
        suffixIcon:
            widget.suffixIcon ??
            (widget.ispassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    child: Icon(
                      isObsecure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                : null),
        hint: Text(
          widget.textFormFieldText ?? "",
          style: AppFontStyles.title,
        ),
      ),
    );
  }
}
