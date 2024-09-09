import 'dart:math';

import 'package:e_commerce_shoes/domain/model/user_model.dart';
import 'package:e_commerce_shoes/presentation/Widget/button.dart';
import 'package:e_commerce_shoes/presentation/Widget/text.dart';
import 'package:e_commerce_shoes/presentation/Widget/textFormFeild.dart';
import 'package:e_commerce_shoes/data/repository/auth_service.dart';
import 'package:e_commerce_shoes/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterWrapper extends StatelessWidget {
  const RegisterWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Register(),
    );
  }
}

class Register extends StatelessWidget {
  Register({super.key});
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(context, "/Home",(route)=>false);
        }
        return  Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 05,),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const TextCustom(
          text: "Let’s Get Started",
        ),
        const TextCustom(
          text: "Create an new account",
        ),
        Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Textformfeildcustom(
                  KeyboardType: TextInputType.emailAddress,
                  controller: nameController,
                  label: "Full Name",
                  hintText: "Enter your FullName",
                  prefixIcon: Icons.person,
                ),
                const SizedBox(
                  height: 15,
                ),
                Textformfeildcustom(
                  KeyboardType: TextInputType.visiblePassword,
                  controller: emailController,
                  label: "Your Email",
                  hintText: "Enter your Email",
                  prefixIcon: Icons.lock,
                ),
                const SizedBox(
                  height: 15,
                ),
                Textformfeildcustom(
                  KeyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  label: "Password",
                  hintText: "Enter your password",
                  prefixIcon: Icons.lock,
                ),
                const SizedBox(
                  height: 15,
                ),
                Textformfeildcustom(
                  KeyboardType: TextInputType.visiblePassword,
                  controller: passwordAgainController,
                  label: "Password Again",
                  hintText: "Enter your password Again",
                  prefixIcon: Icons.lock,
                ),
                const SizedBox(
                  height: 25,
                ),
                ButtonCustomized(
                    text: "Sign Up",
                    color: const Color.fromARGB(255, 207, 57, 233),
                    width: 300, // Specific width
                    height: 50,
                    borderRadius: 10,
                    onPressed: ()async {
                      UserModel user = UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        passwordAgain: passwordAgainController.text
                      );
                  context.read<AuthBloc>().add(SignUpEvent(user: user));

                       Navigator.pushNamed(context, "/Login");
                    }
                    ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 45,
                    ),
                    const TextCustom(
                      text: "Do you have a account? ",
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    TextCustom(
                      onTap: () => Navigator.pushNamed(context,"/Login"),
                      text: "Sign in",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 207, 57, 233),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    )
    );
      },
    );
    
  }
}
