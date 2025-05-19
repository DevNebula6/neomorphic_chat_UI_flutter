import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neomorphic_chat_flutter/Auth/auth_service.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_bloc.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_event.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_state.dart';
import 'package:neomorphic_chat_flutter/screens/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = await AuthService.mockBackend();
  
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(authService)..add(const AuthEventInitialise()),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Flutter Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateUninitialized) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Initializing...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[600],
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AuthStateLoggedOut) {
            return const OnboardingScreen();
          } else {
            return const OnboardingScreen();
          }
        },
      ),
    );
  }
}