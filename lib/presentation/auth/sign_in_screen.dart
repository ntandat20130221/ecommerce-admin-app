import 'package:ecommerce_admin_app/data/repositories/auth_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/auth_repository_impl.dart';
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
  final AuthRepository authRepository = AuthRepositoryImpl();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;
  bool isLoading = false;
  bool isRememberMe = true;

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
                          controller: emailController,
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
                          controller: passwordController,
                          style: TextStyle(color: Colors.grey[600]),
                          keyboardType: TextInputType.text,
                          obscureText: !passwordVisible,
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
                              icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600]),
                              onPressed: () => setState(() => passwordVisible = !passwordVisible),
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
                        isLoading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 14, 35, 221),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(defaultPadding / 2),
                                    ),
                                  ),
                                  child: const Text('SIGN IN', style: TextStyle(color: Colors.white, fontSize: 18)),
                                  onPressed: () async {
                                    setState(() => isLoading = true);
                                    final admin = await authRepository.signIn(emailController.text, passwordController.text);
                                    setState(() => isLoading = false);

                                    if (admin == null && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username or password is incorrect.')));
                                      return;
                                    }

                                    if (admin != null && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in successfully.')));
                                      final prefs = await SharedPreferences.getInstance();
                                      prefs.setBool('IS_SIGNED_IN', true);
                                      widget.onSignedIn();
                                    }
                                  },
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
