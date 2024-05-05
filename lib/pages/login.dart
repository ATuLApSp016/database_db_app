import 'package:database_db_app/appDatabase/app_datebase.dart';
import 'package:database_db_app/appDatabase/app_routes.dart';
import 'package:database_db_app/appDatabase/ui_helper.dart';
import 'package:database_db_app/utils/app_colors.dart';
import 'package:database_db_app/utils/app_images.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var mailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(21),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 345,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 41),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width: 38,
                        height: 38,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(Icons.keyboard_backspace_rounded)),
                      ),
                    ),
                    CTextWidget(
                      cText: 'Login',
                      cTextStyle: TextStyle(
                        color: ColorsConstant.primary_Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    CTextWidget(
                      cText:
                          'Login now to track all your expenses\nand income at a place!',
                      cTextStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 21),
                  ],
                ),
              ),
              CustomTextField(
                hintStyle: TextStyle(
                  color: ColorsConstant.mainText_Color,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
                prefixIconImage: ImageConstant.ic_mail,
                fillColor: ColorsConstant.white_Color,
                keyType: TextInputType.emailAddress,
                controller: mailController,
                hintText: 'Ex: abc@example.com',
                headTitle: 'Email',
              ),
              CustomTextField(
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: ColorsConstant.mainText_Color,
                ),
                prefixIconImage: ImageConstant.ic_lock,
                fillColor: ColorsConstant.white_Color,
                keyType: TextInputType.text,
                controller: passController,
                headTitle: 'Your Password',
                hintText: '**********',
                obscureText: true,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          decorationColor: ColorsConstant.primary_Color,
                          decoration: TextDecoration.underline,
                          color: ColorsConstant.primary_Color,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 21),
              ElevatedBTN(
                cText: 'Login',
                onTap: () async {
                  var db = AppDatabase.instance;
                  var check = await db.loginUser(mailController.text.toString(),
                      passController.text.toString());

                  if (check) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.HOME_PAGE);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid credential!!')));
                  }
                },
              ),
              Divider(
                color: ColorsConstant.black_Color,
                endIndent: 16,
                thickness: 1,
                height: 61,
                indent: 16,
              ),
              OutlineGoogleBTN(
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CTextWidget(
                      cText: 'Don’t have an account?',
                      cTextStyle: TextStyle(
                        color: ColorsConstant.black_Color,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.SIGNUP_PAGE);
                      },
                      child: CTextWidget(
                        cText: '\tRegister',
                        cTextStyle: TextStyle(
                          color: ColorsConstant.primary_Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
