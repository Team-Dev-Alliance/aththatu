import 'package:flutter/material.dart';
import '../Home/home_page.dart';
import '../Profile/profile_page.dart';
import '../Home/seller_home_page.dart';
import '../Orders/seller_orders_page.dart';
import '../Authentication/login.dart';
import '../Authentication/signup.dart';
import '../Analytics/analytics_page.dart';
import '../Orders/add_product_page.dart';
import '../Category/category.dart';
import '../Cart/cart_page.dart';
import '../SellerProfile/seller_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        '/seller_profile': (context) => const SellerProfile(),
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
