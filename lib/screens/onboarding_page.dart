import 'package:flutter/material.dart';
import 'package:neomorphic_chat_flutter/models/onboarding_page_model.dart';
import 'package:neomorphic_chat_flutter/screens/register_page.dart';
import 'package:neomorphic_chat_flutter/screens/signin_page.dart';
import 'package:neomorphic_chat_flutter/utilities/Text_styles.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/button_neomorphic.dart';
import 'package:neomorphic_chat_flutter/utilities/widgets/logo_neomorphic.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static List<OnboardingPage> pages = [
    OnboardingPage(
      icon: Icon(Icons.chat_bubble_outline, size: 80, color: Colors.blueGrey[800]),
      headline: 'Welcome to Chat',
      text: 'A modern messaging application with elegant neomorphic design for a unique tactile experience',
    ),
    OnboardingPage(
      icon: Icon(Icons.architecture, size: 80, color: Colors.blueGrey[800]),
      headline: 'Clean Architecture',
      text: 'Built with BLoC pattern for efficient state management and clean architecture separating presentation, domain, and data layers',
    ),
    OnboardingPage(
      icon: Icon(Icons.security, size: 80, color: Colors.blueGrey[800]), 
      headline: 'Mock Authentication',
      text: 'Your login state is stored with SharedPreferences while maintaining complete privacy with local authentication',
    ),
    OnboardingPage(
      icon: Icon(Icons.person_outline, size: 80, color: Colors.blueGrey[800]), 
      headline: 'Start your journey',
      text: 'Start your experience with a tactile touch',
    ),
  ];

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return buildIsomorphicStarterPages(
              pages,
              index
            );
        }
      ),
    );
  }
  
  
  Widget buildIsomorphicStarterPages(List<OnboardingPage> pages, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          // Logo
          neomorphicLogo(pages[index].icon),

          const SizedBox(height: 50),

          // Title
          Text(
            pages[index].headline ?? '',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // Subtitle
          Text(
            pages[index].text ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey[600],
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 80),

          // Sign in button
          neomorphicButton(
            onPressed: () {
              (index < pages.length-1) ? 
              // Go to next page 
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              )
              :{
                //navigate to login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SigninPage()),
                ),
              };
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward),
                const SizedBox(width: 12),
                Text(
                  (index < pages.length-1) ? "Next":"Sign In",
                  style: getTextStyle(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          (index < pages.length-1) ? 
          TextButton(
            onPressed: () {
              _pageController.animateToPage(
                pages.length,  // Skip to last page
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[400],
                fontFamily: 'Poppins',
              ),
            ),
          )
          :
          Column(
            children: [
              const SizedBox(height: 10,),
              neomorphicButton(
                onPressed: () {
                  // Register navigation logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => RegisterPage(),)
                    );
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add, color: Colors.blueGrey[800]),
                      const SizedBox(width: 12),
                      Text(
                        "Create Account",
                        style: getTextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
