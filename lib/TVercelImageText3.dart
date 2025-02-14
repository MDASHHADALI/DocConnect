import 'package:flutter/material.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';

class TVerticalImageText3 extends StatelessWidget {
  const TVerticalImageText3({
    super.key,
    required this.image,
    required this.title,
    this.textColor,
    this.backgroundColor=TColors.white,
    this.onTap,
  });

  final String image, title;
  final Color? textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 115,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor??(dark?TColors.black:TColors.white),
                borderRadius: BorderRadius.circular(100),
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
            SizedBox(
              width: 120,
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
            )
          ],
        ),
      ),
    );
  }
}