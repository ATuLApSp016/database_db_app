import 'package:database_db_app/appDatabase/app_datebase.dart';
import 'package:database_db_app/appDatabase/app_routes.dart';
import 'package:database_db_app/appDatabase/ui_helper.dart';
import 'package:database_db_app/models/user_model.dart';
import 'package:database_db_app/utils/app_colors.dart';
import 'package:database_db_app/utils/app_images.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var mailController = TextEditingController();
  var nameController = TextEditingController();
  var passController = TextEditingController();
  var numberController = TextEditingController();

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
                      cText: 'Register',
                      cTextStyle: TextStyle(
                        color: ColorsConstant.primary_Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    CTextWidget(
                      cText: 'Create an account to access all the',
                      cTextStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    CTextWidget(
                      cText: 'features of Expenio!',
                      cTextStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 21),
                  ],
                ),
              ),
              CustomTextField(
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: ColorsConstant.mainText_Color,
                ),
                prefixIconImage: ImageConstant.ic_contact,
                fillColor: ColorsConstant.white_Color,
                keyType: TextInputType.text,
                controller: nameController,
                hintText: 'Ex: Saul Ramirez',
                headTitle: 'Your Name',
              ),
              CustomTextField(
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: ColorsConstant.mainText_Color,
                ),
                prefixIconImage: ImageConstant.ic_contact,
                fillColor: ColorsConstant.white_Color,
                keyType: TextInputType.number,
                controller: numberController,
                hintText: 'Ex: XXXXXXXXXX',
                headTitle: 'Your Number',
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
              const SizedBox(height: 41),
              ElevatedBTN(
                cText: 'Register',
                onTap: () async{
                  var db = AppDatabase.instance;
                  var check = await db.addNewUser(UserModel(
                      uid: 0,
                      uName: nameController.text.toString(),
                      uEmail: mailController.text.toString(),
                      uNumber: numberController.text.toString(),
                      uPassword: passController.text.toString()));

                  if (check) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.SIGNIN_PAGE);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already registered!!'),action: SnackBarAction(label: 'Login Now', onPressed: (){
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.SIGNIN_PAGE);
                    }),));
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CTextWidget(
                      cText: 'Already have an account?',
                      cTextStyle: TextStyle(
                        color: ColorsConstant.black_Color,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CTextWidget(
                        cText: '\tLogin',
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
