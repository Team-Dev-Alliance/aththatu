import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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

import '../Orders/order_history_page.dart';
import '../Orders/order_details_page.dart';
import '../Orders/order_model.dart' as order_model;
import '../Authentication/signup_details_page.dart';
import '../Cart/cart_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions
              .currentPlatform, // Ensure this is configured correctly
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
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
      ),
      
      home: AuthWrapper(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/signup_details':
            (context) =>
                const SignupDetailsPage(fullName: '', email: '', userType: ''),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/seller_home': (context) => const SellerHomePage(),
        '/seller_orders': (context) => const SellerOrdersPage(),
        '/analytics': (context) => const AnalyticsPage(),
        '/add_product': (context) => const AddProductPage(),
        '/categories': (context) => const CategoryScreen(),
        '/cart': (context) => const CartPage(),
        '/order_history': (context) => const OrderHistoryPage(),
        '/order_details':
            (context) => OrderDetailsPage(
              order: order_model.Order(
                orderId: '',
                price: 0.0,
                timestamp: DateTime.now(),
                products: [],
                customer: order_model.Customer(
                  name: '',
                  address: '',
                  phone: '',
                  email: '',
                  avatarUrl: '',
                  memberSince: '',
                ),
              ),
            ),
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
          return FutureBuilder<DocumentSnapshot>(
            future:
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (userSnapshot.hasError ||
                  !userSnapshot.hasData ||
                  !userSnapshot.data!.exists) {
                return const LoginPage(); // Fallback to login if user data is missing
              }

              final userData =
                  userSnapshot.data!.data() as Map<String, dynamic>;
              final userType = userData['userType'] as String? ?? 'Customer';
              final isSeller = userType == 'Seller';

              return isSeller ? const SellerHomePage() : const HomePage();
            },
          );
        }
        return const LoginPage();
      },
    );
  }
}
