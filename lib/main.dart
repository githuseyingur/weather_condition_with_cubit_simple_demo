import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/home/service/home_service.dart';
import 'package:weather_app/feature/home/viewmodel/home_cubit.dart';
import 'package:weather_app/feature/splash/view/splash_view.dart';
import 'product/service/project_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    final HomeCubit homeCubit =
        HomeCubit(HomeService(ProjectNetworkManager.instance.weatherDio))
          ..fetchItem(null, null);
    return BlocProvider(
      create: (_) => homeCubit,
      child: MaterialApp(
        home: const SplashView(),
        theme: ThemeData.dark(useMaterial3: false),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
