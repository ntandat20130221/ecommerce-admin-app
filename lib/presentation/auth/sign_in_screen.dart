import 'package:ecommerce_admin_app/presentation/auth/sign_up_screen.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.onSignedIn});

  final void Function() onSignedIn;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var isRememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                const Column(
                  children: [
                    Icon(Icons.directions_run, color: Colors.white, size: 100),
                    Text('Welcome Back', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    Text('Sign in to continue', style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 80),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.grey[600]),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(defaultPadding / 2),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
                            filled: true,
                            fillColor: const Color(0xFFE7EDEB),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          style: TextStyle(color: Colors.grey[600]),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(defaultPadding / 2),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
                            filled: true,
                            fillColor: const Color(0xFFE7EDEB),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[600],
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility, color: Colors.grey[600]),
                              onPressed: () => {},
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => isRememberMe = !isRememberMe),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Checkbox(value: isRememberMe, onChanged: (value) => setState(() => isRememberMe = value ?? true))),
                                    const SizedBox(width: defaultPadding / 2),
                                    const Text('Remember me'),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 2),
                                child: Text('Forgot password?', style: TextStyle(color: Color.fromARGB(255, 33, 110, 255))),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 14, 35, 221),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(defaultPadding / 2),
                              ),
                            ),
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();
                              prefs.setBool('IS_SIGNED_IN', true);
                              widget.onSignedIn();
                            },
                            child: const Text('SIGN IN', style: TextStyle(color: Colors.white, fontSize: 18)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?', style: TextStyle(color: Colors.white)),
                            const SizedBox(width: defaultPadding / 2),
                            InkWell(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen())),
                              borderRadius: BorderRadius.circular(defaultPadding / 4),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 2),
                                child: Text('Sign up', style: TextStyle(color: Color.fromARGB(255, 33, 110, 255))),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
