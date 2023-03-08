import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:prodel_admin/ui/screen/dashboard_screen.dart';
import 'package:prodel_admin/ui/screen/home_screen.dart';
import 'package:prodel_admin/ui/screen/widget/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 228, 224, 224),
                      hintText: "Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.black,
                      ),
                      suffixIcon: const Icon(
                        Icons.visibility,
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 228, 224, 224),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 200,
                child: CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Homescreen()),
                    );
                  },
                  label: 'Login',
                ),
              ),
              // SizedBox(
              //   width: 180,
              //   child: TextField(
              //     textAlign: TextAlign.center,
              //     decoration: InputDecoration(
              //         filled: true,
              //         fillColor: Color.fromARGB(255, 228, 224, 224),
              //         hintText: "Login",
              //         hintStyle: const TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.black,
              //         ),
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(60),
              //           borderSide: BorderSide.none,
              //         )),
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const Homescreen()),
              //       );
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
            ],
          )),
        ));
  }
}
