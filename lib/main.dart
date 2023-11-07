import "package:flutter/material.dart";
import "package:flutter_razorpay_demo/screen/home_screen.dart";
import "package:flutter_razorpay_demo/singletons/dio_singleton.dart";
import "package:flutter_razorpay_demo/singletons/navigation_singleton.dart";
import "package:keyboard_dismisser/keyboard_dismisser.dart";

/*
Account credential:
Website: dashboard.razorpay.com
MOB: ******0482
OTP: ******
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioSingleton().addPrettyDioLoggerInterceptor();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: MaterialApp(
        title: "Razorpay Demo",
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.blue,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.blue,
        ),
        navigatorKey: NavigationSingleton().navigatorKey,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
