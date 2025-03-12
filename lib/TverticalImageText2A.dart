import 'package:flutter/material.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';

class TVerticalImageText2 extends StatelessWidget {
  const TVerticalImageText2({
    super.key,
    required this.image,
    required this.title,
    required this.title2,
    this.textColor,
    this.backgroundColor=TColors.white,
    this.onTap, required this.borderRad,
  });

  final String image, title;
  final Color? textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final double borderRad;
  final dynamic title2;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              height: 110,
              width: 110,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor??(dark?TColors.black:TColors.white),
                borderRadius: BorderRadius.circular(borderRad),
                border: Border.all(color: Colors.black),
              ),
              child:  Center(
                  child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    // color: dark?TColors.light:TColors.dark,
                  )),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Column(
              children: [
                SizedBox(
                  width: 110,
                  child: Center(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: textColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      title2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: textColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}