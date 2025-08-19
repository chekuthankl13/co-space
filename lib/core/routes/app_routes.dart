import 'package:co_workspace/core/di/di_injection.dart';
import 'package:co_workspace/feature/booking/logic/booking_cubit.dart';
import 'package:co_workspace/feature/booking/presentation/booking_screen.dart';
import 'package:co_workspace/feature/details/logic/detail_cubit.dart';
import 'package:co_workspace/feature/details/presentation/detail_screen.dart';
import 'package:co_workspace/feature/home/logic/cubit/home_cubit.dart';
import 'package:co_workspace/feature/home/presentation/home_screen.dart';
import 'package:co_workspace/feature/search/logic/search_cubit.dart';
import 'package:co_workspace/feature/search/presentation/search_screen.dart';
import 'package:co_workspace/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  Route? routes(RouteSettings settings) {
    switch (settings.name) {
      case "/splash":
        return goToPage(const SplashScreen());
      case "/home":
        return goToPage(
          BlocProvider(
            create: (context) => sl<HomeCubit>()..fetch(),
            child: HomeScreen(),
          ),
        );
      case "/detail":
        var id = settings.arguments as String;
        return goToPage(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<DetailCubit>()..getDetail(id),
              ),
              // BlocProvider(create: (context) => SubjectBloc()),
            ],
            child: DetailScreen(id: id,),
          ),
        );
         case "/booking":
        return goToPage(
          BlocProvider(
            create: (context) => sl<BookingCubit>()..loadBooking(),
            child: BookingScreen(),
          ),
        );
        case "/search":
        return goToPage(
          BlocProvider(
            create: (context) => sl<SearchCubit>(),
            child: SearchScreen(),
          ),
        );
      default:
        return null;
    }
  }
}

goToPage(child) => PageTransition(type: PageTransitionType.fade, child: child);
