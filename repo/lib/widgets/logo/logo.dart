import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:semper_web/app_resources/app_assets.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/app_resources/app_strings.dart';
import 'package:semper_web/extensions/string.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/widgets/text/div.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Column(
        children: [
          LogoIcon(),
          LogoText(),
        ],
      ),
    );
  }
}

class LogoIconMobile extends StatelessWidget {
  final double dimension = 43.1;
  final double borderRadius = 9.5;

  const LogoIconMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Image.asset(AppAssets.easy_21x1_png),
      ),
    );
  }
}

class LogoIconTabletDesktop extends StatelessWidget {
  final double dimension = 40.1;
  final double borderRadius = 9.5;

  const LogoIconTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Image.asset(
          AppAssets.easy_49x1_png,
        ),
      ),
    );
  }
}

class LogoIcon extends StatelessWidget {
  const LogoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout.builder(
      mobile: (ctx) => const LogoIconMobile(),
      tablet: (ctx) => const LogoIconTabletDesktop(),
    );
  }
}

class LogoTextTableDesktop extends StatelessWidget {
  const LogoTextTableDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Div(AppString.semper).green();
  }
}

class LogoTextMobile extends StatelessWidget {
  const LogoTextMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Div(AppString.semper.capitalize()).green().rem(.9);
  }
}

class LogoText extends StatelessWidget {
  const LogoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (ctx) => const LogoTextMobile(),
      tablet: (ctx) => const LogoTextTableDesktop(),
    );
  }
}
