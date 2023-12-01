import 'package:flutter/material.dart';
import 'package:my_app/features/auth/screens/auth_screen.dart';
import 'package:my_app/global_variables.dart';
import 'package:my_app/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniCart',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 0, 174, 255),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("UniCart"),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/unicart_logo.png',
                  width: 200, // Increase the image width
                  height: 200, // Increase the image height
                ),
                const SizedBox(height: 50), // Decrease the spacing between the image and text
                const Text(
                  "SaiU's First E-Commerce App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 50), // Decrease the spacing between the text and button
                Builder(
                  builder: (context) {
                    return ButtonTheme(
                      minWidth: 500,
                      height: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AuthScreen.routeName);
                        },
                        child: const Text(
                          "Click",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
