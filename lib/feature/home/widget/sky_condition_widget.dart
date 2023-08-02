import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/feature/home/viewmodel/home_cubit.dart';
import 'package:weather_app/product/constants/color_constants.dart';
import 'package:weather_app/product/enums/sky_condition.dart';

class SkyConditionAnimationWidget extends StatelessWidget {
  const SkyConditionAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SkyCondition? skyCondition = context.read<HomeCubit>().skyCondition;
    DateTime? sunSet = context.read<HomeCubit>().sunSet;
    switch (skyCondition) {
      case SkyCondition.clear:
        if (DateTime.now().compareTo(sunSet!) > 0) {
          return Column(children: [
            Lottie.asset("assets/animations/night.json", width: 240, height: 240),
            const Text(
              "CLEAR",
              style: TextStyle(color: ColorConstants.skyConditionGreenColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]);
        } else {
          return Column(children: [
            Lottie.asset("assets/animations/clear.json", width: 240, height: 240),
            const Text(
              "Clear",
              style: TextStyle(color: ColorConstants.skyConditionGreenColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]);
        }

      case SkyCondition.fewClouds:
        if (DateTime.now().compareTo(sunSet!) > 0) {
          return Column(children: [
            Lottie.asset("assets/animations/night.json", width: 240, height: 240),
            const Text(
              "Few Clouds",
              style: TextStyle(color: ColorConstants.skyConditionGreenColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]);
        } else {
          return Column(children: [
            Lottie.asset("assets/animations/few_clouds.json", width: 240, height: 240),
            const Text(
              "Few Clouds",
              style: TextStyle(color: ColorConstants.skyConditionGreenColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]);
        }

      case SkyCondition.partlyClouds:
        if (DateTime.now().compareTo(sunSet!) > 0) {
          return Column(children: [
            Lottie.asset("assets/animations/night.json", width: 240, height: 240),
            const Text(
              "Partly Cloudy",
              style: TextStyle(color: ColorConstants.skyConditionGreenColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]);
        } else {
          return Column(children: [
            Lottie.asset("assets/animations/partly_cloudy.json", width: 240, height: 240),
            const Text(
              "Partly Cloudy",
              style: TextStyle(color: ColorConstants.skyConditionGreenColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]);
        }

      case SkyCondition.cloudy:
        if (DateTime.now().compareTo(sunSet!) > 0) {
          return Column(children: [
            Lottie.asset("assets/animations/night.json", width: 240, height: 240),
            const Text(
              "Cloudy",
              style: TextStyle(color: ColorConstants.skyConditionGreenColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]);
        } else {
          return Column(children: [
            Lottie.asset("assets/animations/cloud.json", width: 240, height: 240),
            const Text(
              "Cloudy",
              style: TextStyle(color: ColorConstants.skyConditionGreenColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]);
        }

      default:
        return const SizedBox(
          child: Text("loading..."),
        );
    }
  }
}
