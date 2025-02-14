import 'package:flutter/material.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor=TColors.white,
    this.backgroundColor=TColors.white,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

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
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor??(dark?TColors.black:TColors.white),
                borderRadius: BorderRadius.circular(100),
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
            SizedBox(
              width: 72,
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}