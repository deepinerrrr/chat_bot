import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'chat_screen.dart';
// import 'package:floating/floating.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _createOverlayWindow();
  }

  void _createOverlayWindow() async {
    await FlutterOverlayWindow.showOverlay(
      width: 200,
      height: 200,
      alignment: OverlayAlignment.topCenter,
      enableDrag: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}
