import 'package:flutter/material.dart';
import 'package:neomorphic_chat_flutter/models/onboarding_page_model.dart';

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
          return _buildOnboardingPage(
              pages,
              index
            );
        }
      ),
    );
  }
  
  
  Widget _buildOnboardingPage(List<OnboardingPage> pages, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          _neomorphicLogo(pages[index].icon),

          const SizedBox(height: 50),

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
          neomorphicButton(
            onPressed: () {
              (index < pages.length-1) ? 
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              )
              :
              {//navigate to login page

              };
            },
            child: Center(
              child: Text(
                (index < pages.length-1) ? 
                "Next" : "SignIn",
                style: _getTextStyle(),
              ),
            ),
          ),

          const SizedBox(height: 20),
          (index < pages.length-1) ? 
          TextButton(
            onPressed: () {
              _pageController.animateToPage(
                pages.length,  // Skip to login page
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
                  // Register logic here
                  print('Register pressed');
                },
                child: Center(
                  child: Text(
                    "Register",
                    style: _getTextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _neomorphicLogo(Icon icon) {
    return Container(
      height: 160,
      width: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            blurRadius: 9,
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            spreadRadius: 3,
          ),
          const BoxShadow(
            blurRadius: 15,
            color: Colors.white,
            offset: Offset(-4, -4),
            spreadRadius: 5,
          ),
        ],
      ),
      child:icon,
    );
  }
  
  Widget neomorphicButton({
    required Widget child,
    VoidCallback? onPressed,    
  }) {

    bool isPressed = false;

    return StatefulBuilder(
      builder: (context, setState) =>
      GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) {
          setState(() => isPressed = false);
          if (onPressed != null) onPressed();
        },
        onTapCancel: () => setState(() => isPressed = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical:10 ),
          height: 60,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: isPressed
            // Pressed state - inverted shadows
            ? [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.white.withOpacity(0.8),
                  offset: Offset(2, 2),
                  spreadRadius: 1,
                ),
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade500,
                  offset: Offset(-2, -2),
                  spreadRadius: 1,
                ),
              ]
            // Default state
            : [
                BoxShadow(
                  blurRadius: 9,
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  spreadRadius: 3,
                ),
                BoxShadow(
                  blurRadius: 15,
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  spreadRadius: 5,
                ),
              ],
          ),
          child: DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.copyWith(
              color: isPressed ? Colors.blueGrey[400] : Colors.blueGrey[800],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: 25,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    );
  }
}
