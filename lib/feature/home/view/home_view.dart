import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/home/viewmodel/home_cubit.dart';
import 'package:weather_app/feature/home/widget/home_app_bar.dart';
import 'package:weather_app/product/extension/responsive/responsive.dart';
import 'package:weather_app/product/utility/loading/loading_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeInitial || state is HomeLoading) {
        return const LoadingView();
      } else if (state is HomeItemLoaded) {
        return NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              final notificationContext = notification.context;
              if (notificationContext != null) {
                notificationContext.read<HomeCubit>().fetchItem();
              }
            }
            return true;
          },
          child: Scaffold(
            appBar: HomeAppBar(
              context: context,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                  height: context.dynamicHeight(0.60),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Card(
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              "Konya",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${context.read<HomeCubit>().weatherModel!.temp}C°",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
