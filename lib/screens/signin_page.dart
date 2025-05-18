import 'package:flutter/material.dart';
import 'package:neomorphic_chat_flutter/screens/register_page.dart';
import 'package:neomorphic_chat_flutter/utilities/Text_styles.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/button_neomorphic.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/logo_neomorphic.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/textfield_neomorphic.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blueGrey[800]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                
                // Logo
                neomorphicLogo(
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.blueGrey[800],
                  )
                ),
                
                const SizedBox(height: 40),
                
                // Title
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 15),
                
                // Subtitle
                Text(
                  'Sign in to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[600],
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 50),
                
                // Email Field
                buildNeomorphicTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 25),
                
                // Password Field
                buildNeomorphicTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.blueGrey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password logic
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey[600],
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Sign In Button
                neomorphicButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Implement login logic
                      print('Email: ${_emailController.text}');
                      print('Password: ${_passwordController.text}');
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login, color: Colors.blueGrey[800]),
                      const SizedBox(width: 12),
                      Text(
                        "Sign In",
                        style: getTextStyle(),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to SignIn Page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder:(context) => RegisterPage())
                      );
                    },
                    child: Text(
                      'New User? Sign up now',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey[300],
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}