import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_bloc.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_event.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/button_neomorphic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Neomorphic Chat'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blueGrey[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventSignOut());
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Neomorphic Chat!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'You are successfully logged in',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[600],
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 40),
            neomorphicButton(
              onPressed: () {
                // Navigate to chat screen
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat, color: Colors.blueGrey[800]),
                  const SizedBox(width: 12),
                  Text(
                    "Start Chatting",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}