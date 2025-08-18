import 'package:co_workspace/feature/details/presentation/detail_screen.dart';
import 'package:co_workspace/feature/home/presentation/home_screen.dart';
import 'package:co_workspace/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  Route? routes(RouteSettings settings){
    switch (settings.name) {
      case "/splash":
        return goToPage(const SplashScreen());
      case "/home":
      return goToPage(HomeScreen());
      case "/detail":
      return goToPage(DetailScreen());
      default:
        return null;
    }
  }
}

goToPage(child)=>PageTransition(type: PageTransitionType.fade,child:child );