import 'package:flutter/material.dart';
import 'package:nazwa_tiketing/screens/add_movie.dart';
import 'package:nazwa_tiketing/ui/home_screen.dart';
import 'package:nazwa_tiketing/ui/login.dart';
import 'package:nazwa_tiketing/ui/register.dart';

MaterialPageRoute _pageRoute(
        {required Widget body, required RouteSettings settings}) =>
    MaterialPageRoute(builder: (_) => body, settings: settings);
Route? generateRoute(RouteSettings settings) {
  Route? _route;
  final _args = settings.arguments;
  switch (settings.name) {
    case rLogin:
      _route = _pageRoute(body: LoginScreen(), settings: settings);
      break;
    case rRegister:
      _route = _pageRoute(body: RegisterScreen(), settings: settings);
      break;
    case rHome:
      _route = _pageRoute(body: HomeScreen(), settings: settings);
      break;
    case rAdd:
      _route = _pageRoute(body: AddMoviePage(), settings: settings);
      break;
    case rEdit:
      _route = _pageRoute(body: AddMoviePage(), settings: settings);
      break;
  }
  return _route;
}

final NAV_KEY = GlobalKey<NavigatorState>();
const String rLogin = '/login';
const String rRegister = '/register';
const String rHome = '/home';
const String rAdd = '/add_movie';
const String rEdit = '/edit';
