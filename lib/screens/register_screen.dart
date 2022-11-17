import 'package:fit_memoir/constants.dart';
import 'package:fit_memoir/screens/login_screen.dart';
import 'package:fit_memoir/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    var emailCtrl = TextEditingController();
    var pwdCtrl = TextEditingController();
    var userCtrl = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Fit \nMemoir",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 60,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    textfieldChild: TextField(
                      controller: userCtrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Username",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    textfieldChild: TextField(
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Email",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    textfieldChild: TextField(
                      controller: pwdCtrl,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 8,
                    right: 8,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: double.infinity,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: kBlueColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
