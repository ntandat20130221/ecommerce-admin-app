import 'package:ecommerce_admin_app/data/repositories/auth_repository.dart';
import 'package:ecommerce_admin_app/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthRepository authRepository = AuthRepositoryImpl();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: colorBackground,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Material(
          color: colorBackground,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Column(
                  children: [
                    Text('Create Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    Text('Create a new account', style: TextStyle(fontSize: 16)),
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
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: confirmPasswordController,
                          style: TextStyle(color: Colors.grey[600]),
                          keyboardType: TextInputType.text,
                          obscureText: !confirmPasswordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(defaultPadding / 2),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
                            filled: true,
                            fillColor: const Color(0xFFE7EDEB),
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[600],
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(confirmPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600]),
                              onPressed: () => setState(() => confirmPasswordVisible = !confirmPasswordVisible),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
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
                                  child: const Text('SIGN UP', style: TextStyle(color: Colors.white, fontSize: 18)),
                                  onPressed: () async {
                                    setState(() => isLoading = true);
                                    final admin = await authRepository.signUp(emailController.text, passwordController.text);
                                    setState(() => isLoading = false);

                                    if (admin == null && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email already exists.')));
                                    }

                                    if (admin != null && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign up successfully.')));
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?', style: TextStyle(color: Colors.white)),
                            const SizedBox(width: defaultPadding / 2),
                            InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(defaultPadding / 4),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 2),
                                child: Text('Sign in', style: TextStyle(color: Color.fromARGB(255, 33, 110, 255))),
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
