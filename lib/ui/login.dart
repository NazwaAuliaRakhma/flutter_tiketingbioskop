import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nazwa_tiketing/bloc/login/login_cubit.dart';
import 'package:nazwa_tiketing/ui/home_screen.dart';
import 'package:nazwa_tiketing/ui/phone_auth_screen.dart';
import '../utils/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        backgroundColor: Color(0xFF1D1D28), // Background color
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 51, vertical: 137),
              child: Column(
                children: [
                  _buildEmailSection(context),
                  SizedBox(height: 15),
                  _buildPasswordSection(context),
                  SizedBox(height: 36),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      } else if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is! LoginLoading
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().login(
                                        email: context
                                            .read<LoginCubit>()
                                            .emailController
                                            .text,
                                        password: context
                                            .read<LoginCubit>()
                                            .passwordController
                                            .text,
                                      );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: Size(199, 50),
                        ),
                        child: state is LoginLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                  SizedBox(height: 35),
                  Text(
                    "Do you have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white, // Text color
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(199, 50),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Login with",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white, // Text color
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          signInWithGoogle(context);
                        },
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage:
                              NetworkImage('\assets\images\google.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 26),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneAuthScreen()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundImage:
                                NetworkImage('\assets\images\telp.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Login",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white, // Title color
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF1D1D28),
      actions: [
        TextButton(
          onPressed: () {
            // Handle administrator button press
          },
          child: Text(
            'Administrator',
            style: TextStyle(
              color: Colors.blue, // Button text color
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ], // Background color
    );
  }

  Widget _buildEmailSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              "Email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white, // Text color
              ),
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: context.read<LoginCubit>().emailController,
            decoration: InputDecoration(
              hintText: "Enter your email",
              hintStyle: TextStyle(color: Colors.white), // Hint text color
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFF363746), // Text field background color
              // Set text color
              labelStyle: TextStyle(color: Colors.white),
            ),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white), // Set text color
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              "Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white, // Text color
              ),
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: context.read<LoginCubit>().passwordController,
            decoration: InputDecoration(
              hintText: "Enter your password",
              hintStyle: TextStyle(color: Colors.white), // Hint text color
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFF363746), // Text field background color
              // Set text color
              labelStyle: TextStyle(color: Colors.white),
            ),
            obscureText: true,
            style: TextStyle(color: Colors.white), // Set text color
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) return; // The user canceled the sign-in
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }
}
