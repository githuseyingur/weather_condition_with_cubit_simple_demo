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
    TextEditingController cityInputController =
        TextEditingController(); //! kaldır
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text("Search City Name"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              //! CITY PICKER KOY!
              controller: cityInputController,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            if (state is HomeInitial || state is HomeLoading) {
              return const LoadingView();
            } else if (state is HomeItemLoaded) {
              return SingleChildScrollView(
                child: SizedBox(
                    height: context.dynamicHeight(0.60),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Center(
                            child: Column(
                              children: [
                                const Text("Current Location"),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Konya",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${context.read<HomeCubit>().weatherModel!.temp}C°",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              );
            } else {
              return const CircularProgressIndicator();
            }
          })
        ],
      ),
    );
  }
}
