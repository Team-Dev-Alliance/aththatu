import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Home/home_page.dart';
import '../Profile/profile_page.dart';
import '../Home/seller_home_page.dart';
import '../Orders/seller_orders_page.dart';
import '../Authentication/login.dart';
import '../Authentication/signup.dart';
import '../Analytics/analytics_page.dart';
import '../Orders/add_product_page.dart';
import '../category/category.dart';
import '../Cart/cart_page.dart';
import '../Authentication/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aththatu E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.yellow[50],
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/seller_home': (context) => const SellerHomePage(),
        '/seller_orders': (context) => const SellerOrdersPage(),
        '/analytics': (context) => const AnalyticsPage(),
        '/add_product': (context) => const AddProductPage(),
        '/categories': (context) => const CategoryScreen(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final AuthService _authService = AuthService();

  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          final user = snapshot.data!;
          final isSeller = user.email?.endsWith('@seller.com') ?? false;
          return isSeller ? const SellerHomePage() : const HomePage();
        }
        return const LoginPage();
      },
    );
  }
}
