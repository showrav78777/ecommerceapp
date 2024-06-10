import 'package:flutter/material.dart';
import '../size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    required Key key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        errors.length,
        (index) => formErrorText(error: errors[index]),
      ),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        Icon(
          Icons.error,
          color: Colors.red, // Set the color of the error icon
          size: getProportionateScreenWidth(14),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(
          error,
          style: TextStyle(color: Colors.red), // Set the color of the error text
        ),
      ],
    );
  }
}
