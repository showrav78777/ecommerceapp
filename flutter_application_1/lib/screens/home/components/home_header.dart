import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'cart.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(key: UniqueKey()),
          IconBtnWithCounter(
            icon: Icons.shopping_cart,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          // IconBtnWithCounter(
          //  icon: Icons.notifications,
          //   numOfitem: 3,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}