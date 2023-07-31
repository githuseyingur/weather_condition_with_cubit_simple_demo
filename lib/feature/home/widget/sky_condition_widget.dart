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
    DateTime? sunRise = context.read<HomeCubit>().sunRise;
    DateTime? sunSet = context.read<HomeCubit>().sunSet;
    switch (skyCondition) {
      case SkyCondition.clear:
        if (DateTime.now().compareTo(sunSet!) > 0) {
          return Column(children: [
            Lottie.asset("assets/animations/night.json", width: 280, height: 280),
            const Text(
              "Sky Condition : Clear",
              style: TextStyle(color: ColorConstants.darkTextColor, fontSize: 12),
            )
          ]);
        } else {
          return Column(children: [
            Lottie.asset("assets/animations/clear.json", width: 280, height: 280),
            const Text(
              "Sky Condition : Clear",
              style: TextStyle(color: ColorConstants.darkTextColor, fontSize: 12),
            )
          ]);
        }

      case SkyCondition.fewClouds:
        if (DateTime.now().compareTo(sunSet!) > 0) {
          return Column(children: [
            Lottie.asset("assets/animations/night.json", width: 280, height: 280),
            const Text(
              "Sky Condition : Few Clouds",
              style: TextStyle(color: ColorConstants.darkTextColor, fontSize: 12),
            )
          ]);
        } else {
          return Column(children: [
            Lottie.asset("assets/animations/few_clouds.json", width: 280, height: 280),
            const Text(
              "Sky Condition : Few Clouds",
              style: TextStyle(color: ColorConstants.darkTextColor, fontSize: 12),
            )
          ]);
        }

      case SkyCondition.partlyClouds:
        return Column(children: [
          Lottie.asset("assets/animations/partly_cloudy.json", width: 280, height: 280),
          const Text(
            "Sky Condition : Partly Cloudy",
            style: TextStyle(color: ColorConstants.darkTextColor, fontSize: 12),
          )
        ]);
      case SkyCondition.cloudy:
        return Column(children: [
          Lottie.asset("assets/animations/cloud.json", width: 280, height: 280),
          const Text(
            "Sky Condition : Cloudy",
            style: TextStyle(color: ColorConstants.darkTextColor, fontSize: 12),
          )
        ]);
      default:
        return const SizedBox(
          child: Text("loading..."),
        );
    }
  }
}
