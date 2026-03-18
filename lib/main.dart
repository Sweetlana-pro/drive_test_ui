import 'package:drive_test_ui/widgets/auth/auth/auth_model.dart';
import 'package:drive_test_ui/widgets/auth/auth/auth_widget.dart';
import 'package:drive_test_ui/widgets/auth/main_screen/main_screen_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 23, 52, 100),
          foregroundColor: Colors.white, //Color.fromARGB(76, 7, 22, 73),
        ),
      ),
      routes: {
        '/auth': (context) =>
            AuthProvider(model: AuthModel(), child: AuthWidget()),
        '/main_screen': (context) => MainScreenWidget(),
      },
      initialRoute: '/auth',
      //home: AuthWidget(),
    );
  }
}
