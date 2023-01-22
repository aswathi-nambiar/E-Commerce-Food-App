import 'package:e_commerce_food_app/providers/product_provider.dart';
import 'package:e_commerce_food_app/providers/review_cart_provider.dart';
import 'package:e_commerce_food_app/providers/user_provider.dart';
import 'package:e_commerce_food_app/providers/favourites_provider.dart';
import 'package:e_commerce_food_app/screens/authenticate.dart';
import 'package:e_commerce_food_app/screens/home_page/home_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// Provider Class handling all the operations related to
        /// product details
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),

        /// Provider Class handling all the operations related to
        /// product details
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),

        /// Provider Class handling all the operations related to cart
        /// delivery address, placing order
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),

        /// Provider Class handling all the operations related to
        /// favourites
        ChangeNotifierProvider<FavoritesProvider>(
          create: (context) => FavoritesProvider(),
        ),
      ],
      child: CupertinoApp(
        title: 'Food App',
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
          scaffoldBackgroundColor: CupertinoColors.white.withOpacity(0.9),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return const HomePage();
            }
            return const Authenticate();
          },
        ),
      ),
    );
  }
}
