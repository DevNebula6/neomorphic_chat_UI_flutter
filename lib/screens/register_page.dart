import 'package:flutter/material.dart';
import 'package:neomorphic_chat_flutter/screens/signin_page.dart';
import 'package:neomorphic_chat_flutter/utilities/Text_styles.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/button_neomorphic.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/logo_neomorphic.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/textfield_neomorphic.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameControler = TextEditingController();
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
                    Icons.person_add,
                    size: 80,
                    color: Colors.blueGrey[800],
                  )
                ),
                
                const SizedBox(height: 40),
                
                // Title
                Text(
                  'Create Account',
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
                  'Sign up using Email and Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[600],
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 50),

                // Name Field
                buildNeomorphicTextField(
                  controller: _nameControler,
                  hintText: 'Name',
                    prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 25),
                // Email Field
                buildNeomorphicTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                     // Email regex pattern
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
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
                    if (value == null || value.isEmpty ) {
                      return 'Please enter your password';
                    } else 
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    } else 
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Password must contain at least one digit';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 60),
                
                // Register Button
                neomorphicButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add, color: Colors.blueGrey[800]),
                      const SizedBox(width: 12),
                      Text(
                        "Sign up",
                        style: getTextStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to SignIn Page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder:(context) => SigninPage())
                      );
                    },
                    child: Text(
                      'Back to login',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey[600],
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