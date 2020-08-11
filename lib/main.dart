import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_bloc/bloc/auth/auth_bloc.dart';
import 'package:soft_bloc/screen/home_page.dart';
import 'package:soft_bloc/screen/login_page.dart';
import 'package:soft_bloc/screen/splash_screen.dart';
import 'package:soft_bloc/services/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) => AuthBloc(userRepository)..add(AppStarted()),
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatefulWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserRepository get userRepository => widget._userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          } else if (state is Unauthenticated) {
            return LoginPage(
              userRepository: userRepository,
            );
          } else if (state is Authenticated) {
            return HomePage(userData: state.userData);
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}
