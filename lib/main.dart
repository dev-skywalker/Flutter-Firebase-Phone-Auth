import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_bloc/bloc/auth/auth_bloc.dart';
import 'package:soft_bloc/screen/home_page.dart';
import 'package:soft_bloc/screen/login_page.dart';
import 'package:soft_bloc/screen/splash_screen.dart';
import 'package:soft_bloc/services/user_repository.dart';
import 'package:soft_bloc/widgets/create_user.dart';

//int initScreen;

  void main(){
  //Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  initScreen = prefs.getInt("iasScreen");
//  await prefs.setInt("iasScreen", 1);
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
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        "/intro": (context) => IntroScreen(),
        "/login": (context) => LoginPage(userRepository: userRepository),
        "/": (context) => AppState(userRepository: userRepository),
      },
      //initialRoute: initScreen == 0 || initScreen == null ? "intro" : "/",
      initialRoute: "/",
    );
  }
}

class AppState extends StatelessWidget {
  final UserRepository _userRepository;

  AppState({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AuthBloc(UserRepository())..add(AppStarted()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashPage();
          } else if(state is Unauthenticated) {
            return LoginPage(userRepository: _userRepository,);
          } else if (state is Authenticated) {
            //return HomePage(userData: state.userData);
            if(state.userData == null){
              print("create user");
              return CreateUserPage();
            }else {
              print("go Home");
              return HomePage(userData: state.userData);
            }
          } else {
            return SplashPage();
          }
        },
      ),
    );
  }
}
