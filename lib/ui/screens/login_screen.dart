import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodel_admin/blocs/sign_in/sign_in_bloc.dart';
import 'package:prodel_admin/ui/screens/dashboard_screen.dart';
import 'package:prodel_admin/ui/screens/home_screen.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/ui/widgets/custom_button.dart';
import 'package:prodel_admin/ui/widgets/custom_input_form_field.dart';
import 'package:prodel_admin/values/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Homescreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(),
          child: BlocConsumer<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state is SignInFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => const CustomAlertDialog(
                    title: "Login Failed",
                    message:
                        'Please check your email and password and try again.',
                    primaryButtonLabel: 'Ok',
                  ),
                );
              } else if (state is SignInSuccessState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Homescreen(),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Material(
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PRODEL Admin',
                        style: GoogleFonts.cambay(
                          textStyle:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        'Login with email and password to continue',
                        style: GoogleFonts.cambay(
                          textStyle:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInputFormField(
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                        hintText: 'Email',
                        validator: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter an email";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInputFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        isObscure: isObscure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObscure = !isObscure;
                            setState(() {});
                          },
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter password";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onTap: () {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<SignInBloc>(context).add(
                              SignInEvent(
                                email: email,
                                password: password,
                              ),
                            );
                          }
                        },
                        label: 'Login',
                        isLoading: state is SignInLoadingState,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
