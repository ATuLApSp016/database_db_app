
import 'package:database_db_app/pages/home_page.dart';
import 'package:database_db_app/pages/login.dart';
import 'package:database_db_app/pages/signup.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String SIGNIN_PAGE = '/';
  static const String SIGNUP_PAGE = '/signup';
  static const String HOME_PAGE = '/home';


  static Map<String, Widget Function(BuildContext)> routesMap() =>
      {
        AppRoutes.SIGNIN_PAGE: (context) => const SignInPage(),
        AppRoutes.SIGNUP_PAGE: (context) => const SignUpPage(),
        AppRoutes.HOME_PAGE: (context) =>  HomePage(),

      };
}