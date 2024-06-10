import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/screens/splash/splash_screen.dart';

import 'loginandregistration/login.dart';
import 'screens/home/home_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
 // ProductDetails.routeName: (context) => const ProductDetails(),
};
