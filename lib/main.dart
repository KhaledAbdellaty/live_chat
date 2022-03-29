import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:livechat/providers/messages_provider.dart';
import 'package:livechat/providers/navigation_provider.dart';
import 'package:livechat/providers/users_provider.dart';
import 'package:livechat/ui/screens/home_screen.dart';
import 'package:livechat/ui/screens/register_screen.dart';
import 'package:livechat/ui/screens/signin_screen.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersProvider>(create: (context)=>UsersProvider()),
        ChangeNotifierProvider<MessageProvider>(create: (context)=>MessageProvider()),
        ChangeNotifierProvider<NavigateProvider>(create: (context)=>NavigateProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _auth.currentUser != null ? HomeScreen():SignInScreen(),
        routes: {
      HomeScreen.screenRoute : (context) => const HomeScreen(),
      SignInScreen.screenRoute : (context) => SignInScreen(),
      RegisterScreen.screenRoute : (context) => RegisterScreen(),
      },
      ),
    );
  }
}
