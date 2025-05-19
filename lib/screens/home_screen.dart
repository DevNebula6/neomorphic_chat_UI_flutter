import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_bloc.dart';
import 'package:neomorphic_chat_flutter/Auth/bloc/auth_event.dart';
import 'package:neomorphic_chat_flutter/models/chat_message.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/chat_bubble_neomorphic.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/chat_input_neomorphic.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/dialog_neomorphic.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello! I'm your friendly Neomorphic Assistant. How can I help you today?",
      isUser: false,
    ),
  ];

  final Map<String, String> _botResponses = {
    'hello': "Hi there! How can I assist you today?",
    'hi': "Hello! What can I help you with?",
    'how are you': "I'm just a bot, but I'm functioning well. Thanks for asking!",
    'help': "I can help with basic questions. Try asking me about Flutter, neomorphic design, or just chat with me!",
    'bye': "Goodbye! It was nice chatting with you.",
    'what is flutter': "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.",
    'what is neomorphic': "Neomorphic design is a visual style that combines elements of skeuomorphism and flat design. It creates soft UI elements that appear to extrude from the background.",
    'tell me a joke': "Why don't scientists trust atoms? Because they make up everything!",
    'who created you': "I'm a simple hardcoded chatbot created for a Neomorphic Flutter Chat app example.",
    'thank you': "You're welcome! Is there anything else you'd like to know?",
    'thanks': "You're welcome! Is there anything else you'd like to know?",
  };

  void _handleSendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: _messageController.text,
      isUser: true,
    );

    setState(() {
      _messages.add(userMessage);
    });

    _getBotResponse(_messageController.text);
    _messageController.clear();
    
    // Scroll to bottom after a short delay to ensure the list is updated
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _getBotResponse(String userMessage) {
    // Convert user input to lowercase for matching
    final input = userMessage.toLowerCase().trim();
    String responseText = "I'm not sure how to respond to that. Can you try asking something else?";

    // Check for matches in our hardcoded responses
    for (var key in _botResponses.keys) {
      if (input.contains(key)) {
        responseText = _botResponses[key]!;
        break;
      }
    }

    // Delayed response to simulate thinking
    Future.delayed(const Duration(milliseconds: 800), () {
      final botMessage = ChatMessage(
        text: responseText,
        isUser: false,
      );

      setState(() {
        _messages.add(botMessage);
      });
      
      // Scroll to bottom after bot response
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  void _confirmLogout() async {
    final shouldLogout = await showNeomorphicDialog(
      context: context, 
      title: 'Logout Confirmation', 
      content: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      cancelText: 'Cancel',
      icon: Icons.logout,
      iconColor: Colors.red[700],
    );
    
    if (shouldLogout && mounted) {
      context.read<AuthBloc>().add(const AuthEventSignOut());
    }
  }
  
  void _confirmClearConversation() async {
    final shouldClear = await showNeomorphicDialog(
      context: context, 
      title: 'Clear Conversation', 
      content: 'Are you sure you want to clear all messages? This action cannot be undone.',
      confirmText: 'Clear',
      cancelText: 'Cancel',
      icon: Icons.delete_sweep,
      iconColor: Colors.orange[700],
    );
    
    if (shouldClear && mounted) {
      setState(() {
        _messages.clear();
        // Keep only the welcome message
        _messages.add(ChatMessage(
          text: "Hello! I'm your friendly Assistant. How can I help you today?",
          isUser: false,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('ChatBot'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blueGrey[800],
        actions: [
          // Clear conversation button
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Clear conversation',
            onPressed: _messages.length > 1 ? _confirmClearConversation : null,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _confirmLogout,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return neomorphicChatBubble(
                  message: message.text,
                  isUser: message.isUser,
                );
              },
            ),
          ),
          chatInputNeomorphic(
            controller: _messageController,
            onSend: _handleSendMessage,
          ),
        ],
      ),
    );
  }
}