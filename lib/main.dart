import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/screens/welcome_screen.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return somethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return loading();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }

  Widget loading() {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Loading',
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget somethingWentWrong() {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Oops',
              style: TextStyle(
                fontSize: 50.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
