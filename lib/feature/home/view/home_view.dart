import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/home/viewmodel/home_cubit.dart';
import 'package:weather_app/product/constants/color_constants.dart';
import 'package:weather_app/product/constants/space_constants.dart';
import 'package:weather_app/product/constants/string_constants.dart';
import 'package:weather_app/product/extension/responsive/responsive.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController cityInputController = TextEditingController(); //! viewmodel'e kaldır

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            if (state is HomeInitial || state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeItemLoaded) {
              return SingleChildScrollView(
                child: SizedBox(
                    height: context.dynamicHeight(0.7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Center(
                            child: Column(
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
                                Text(
                                  "${context.read<HomeCubit>().weatherModel!.temp}C°",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.regularTextColor),
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
