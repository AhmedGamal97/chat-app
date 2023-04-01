import 'package:chatapp/bloc/auth_bloc.dart';
import 'package:chatapp/cubits/auth_cubit.dart';
import 'package:chatapp/cubits/chat_cubit.dart';
import 'package:chatapp/pages/chatpage.dart';
import 'package:chatapp/pages/loginscreen.dart';
import 'package:chatapp/pages/registerscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => LoginCubit(),),
        // BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        routes: {
          'LoginPage': (context) => LoginPage(),
          'RegisterPage': (context) => RegisterPage(),
          'ChatPage': (context) => ChatPage(),
        },
        initialRoute: 'LoginPage',
      ),
    );
  }
}
