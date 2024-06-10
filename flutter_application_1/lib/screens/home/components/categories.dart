// import 'package:flutter/material.dart';

// import '../../../size_config.dart';

// class Categories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> categories = [
//       {"icon": "assets/images/flash.png", "text": "Flash Deal"},
//       {"icon": "assets/images/bill.png", "text": "Bill"},
//       {"icon": "assets/images/game.png", "text": "Game"},
//       {"icon": "assets/images/images.png", "text": "Daily Gift"},
//       {"icon": "assets/images/more.png", "text": "More"},
//       {"icon": "assets/images/service.png", "text": "Service"},
//     ];
//     return Padding(
//       padding: EdgeInsets.all(getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: List.generate(
//           categories.length,
//           (index) => CategoryCard(
//             icon: categories[index]["icon"],
//             text: categories[index]["text"],
//             press: () {},
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   const CategoryCard({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.press,
//   }) : super(key: key);

//   final String icon, text;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: SizedBox(
//         width: getProportionateScreenWidth(55),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(getProportionateScreenWidth(15)),
//               height: getProportionateScreenWidth(55),
//               width: getProportionateScreenWidth(55),
//               decoration: BoxDecoration(
//                 color: Color(0xFFFFECDF),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Image.asset(icon),
//             ),
//             SizedBox(height: 5),
//             Text(text, textAlign: TextAlign.center)
//           ],
//         ),
//       ),
//     );
//   }
// }
