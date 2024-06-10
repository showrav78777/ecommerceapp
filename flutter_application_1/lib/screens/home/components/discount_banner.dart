import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 120,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 198, 198, 67),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
  child: Text.rich(
    TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 20), // Increase the font size
      children: [
        TextSpan(text: "A Summer Surprise\n"),
        TextSpan(
          text: "Cashback 20%",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.center, // Align the text center
  ),
),

    );
  }
}
