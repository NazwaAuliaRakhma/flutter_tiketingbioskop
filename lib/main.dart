import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nazwa_tiketing/bloc/login/login_cubit.dart';
import 'package:nazwa_tiketing/screens/add_movie.dart';
import 'package:nazwa_tiketing/screens/home_admin.dart';
import 'package:nazwa_tiketing/screens/login_admin.dart';
import 'package:nazwa_tiketing/ui/action_screen.dart';
import 'package:nazwa_tiketing/ui/family_screen.dart';
import 'package:nazwa_tiketing/ui/home_screen.dart';
import 'package:nazwa_tiketing/ui/horror_screen.dart';
import 'package:nazwa_tiketing/ui/login.dart';
import 'package:nazwa_tiketing/ui/history_screen.dart';
import 'package:nazwa_tiketing/ui/profile_screen.dart';
import 'package:nazwa_tiketing/ui/romance_screen.dart';
import 'package:nazwa_tiketing/ui/select_seat.dart';
import 'package:nazwa_tiketing/ui/tiket_screen.dart';
import 'package:nazwa_tiketing/utils/routes.dart';
import 'bloc/register/register_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit())
      ],
      child: MaterialApp(
        title: "Tiketing Bioskop",
        debugShowCheckedModeBanner: false,
        navigatorKey: NAV_KEY,
        onGenerateRoute: generateRoute,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/history': (context) => HistoryScreen(),
          '/profile': (context) => ProfileScreen(),
          '/romance': (context) => RomanceScreen(),
          '/horror': (context) => HorrorScreen(),
          '/action': (context) => ActionScreen(),
          '/family': (context) => FamilyScreen(),
          '/select': (context) => ReservationApp(),
          '/admin': (context) => LoginPage(),
          '/homeAdmin': (context) => MovieScreen(),
          '/add_movie': (context) => AddMoviePage(),
          '/tiket': (context) => TicketScreen(),
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
