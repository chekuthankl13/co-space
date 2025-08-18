import 'package:co_workspace/common/int_cubit.dart';
import 'package:co_workspace/core/di/di_injection.dart';
import 'package:co_workspace/core/routes/app_routes.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:co_workspace/feature/home/logic/scroll_cubit.dart';
import 'package:co_workspace/feature/home/logic/slider_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await diInit();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<ScrollCubit>()), 
      BlocProvider(create: (_) => sl<SliderCubit>()),
      BlocProvider(create: (_) => sl<IntCubit>())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        initialRoute: "/splash",
        navigatorKey: navigatorKey,
        onGenerateRoute: AppRoutes().routes,
      ),
    );
  }
}
