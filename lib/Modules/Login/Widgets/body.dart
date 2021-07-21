import 'package:flutter/material.dart';
import 'package:baazaru/cons.dart';
import 'package:baazaru/Modules/Login/Widgets/background.dart';
import 'package:baazaru/Modules/Signup/index.dart';
import 'package:baazaru/Widgets/account_exists.dart';
import 'package:baazaru/Widgets/rounded_button.dart';
import 'package:baazaru/Widgets/rounded_input_field.dart';
import 'package:baazaru/Widgets/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            TextButton(
              child: Text(
                "Forgot password?",
                style: TextStyle(color: primaryColor),
              ),
              onPressed: () {
                Navigator.pushNamed(context, FORGET_PAGE);
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
