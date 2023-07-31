import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/feature/home/service/home_service.dart';
import 'package:weather_app/feature/home/viewmodel/home_cubit.dart';
import 'package:weather_app/feature/home/widget/sky_condition_widget.dart';
import 'package:weather_app/product/constants/color_constants.dart';
import 'package:weather_app/product/constants/space_constants.dart';
import 'package:weather_app/product/constants/string_constants.dart';
import 'package:weather_app/product/extension/responsive/responsive.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController cityInputController = TextEditingController(); //! cubit'e kaldır

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: SpaceConstants.big,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                //! CITY PICKER KOY!
                style: const TextStyle(color: ColorConstants.lightGrey),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: const BorderSide(color: ColorConstants.lightGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: const BorderSide(color: ColorConstants.primaryOrange)),
                    hintText: 'Search City',
                    hintStyle:
                        const TextStyle(color: ColorConstants.hintTextColor, fontSize: 12, fontWeight: FontWeight.w400),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: ColorConstants.lightGrey,
                    filled: true,
                    fillColor: ColorConstants.searchBoxFillColor),

                cursorColor: ColorConstants.primaryOrange,
                cursorWidth: 1.6,
                cursorHeight: 20,
                textAlignVertical: TextAlignVertical.center,
                controller: cityInputController,
              ),
            ),
            const SizedBox(
              height: SpaceConstants.small,
            ),
            SizedBox(
              width: context.dynamicWidth(0.72),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.primaryOrange),
                  child: const Text("Search")),
            ),
            const SizedBox(
              height: SpaceConstants.small,
            ),
            SizedBox(
                height: context.dynamicHeight(0.76),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Center(
                        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                          if (state is HomeInitial || state is HomeLoading) {
                            return const CircularProgressIndicator(
                              color: ColorConstants.darkGrey,
                            );
                          } else if (state is HomeItemLoaded) {
                            return Column(
                              children: [
                                const Text(
                                  StringConstants.currentLocation,
                                  style: TextStyle(fontSize: 9, color: ColorConstants.darkTextColor),
                                ),
                                const SizedBox(
                                  height: SpaceConstants.verySmall,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: ColorConstants.darkGrey, borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    context.read<HomeCubit>().currentLocationCity ??
                                        StringConstants.getCityLocationErrorText,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: SpaceConstants.small,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${context.read<HomeCubit>().weatherModel!.temp}C°",
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.regularTextColor),
                                    ),
                                    Text(
                                      " (feels like : ${context.read<HomeCubit>().weatherModel!.feelsLike}C°)",
                                      style: const TextStyle(
                                          fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.darkGrey),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    //! WİDGET
                                    child: SkyConditionAnimationWidget()),
                                Row(
                                  children: [
                                    Lottie.asset("assets/animations/humidity.json", width: 40, height: 40),
                                    Text(
                                      "${context.read<HomeCubit>().weatherModel!.humidity}",
                                      style: TextStyle(
                                          color:
                                              int.parse(context.read<HomeCubit>().weatherModel!.humidity.toString()) >
                                                      60
                                                  ? Colors.blue
                                                  : ColorConstants.lightGrey),
                                    ),
                                    const Spacer(),
                                    Lottie.asset("assets/animations/wind.json", width: 40, height: 40),
                                    Text("${context.read<HomeCubit>().weatherModel!.windSpeed}"),
                                  ],
                                ),
                                const SizedBox(
                                  height: SpaceConstants.verySmall,
                                ),
                                Text(
                                  "Sun Rise : ${DateFormat(' kk:mm').format(context.read<HomeCubit>().sunRise!)}",
                                  style: const TextStyle(color: ColorConstants.hintTextColor, fontSize: 12),
                                ),
                                Text(
                                  "Sun Set : ${DateFormat(' kk:mm').format(context.read<HomeCubit>().sunSet!)}",
                                  style: const TextStyle(color: ColorConstants.hintTextColor, fontSize: 12),
                                ),
                                const Text(
                                  "(UTC +3)",
                                  style: TextStyle(color: ColorConstants.hintTextColor, fontSize: 12),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator(
                              color: ColorConstants.darkGrey,
                            );
                          }
                        }),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
