import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/signup_controller.dart';

import '../../../doctor/Signup/DocSignupController.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';

class DocTermsAndConditionCheckbox extends StatelessWidget {
  const DocTermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = DocSignupController.instance;
    return Row(
      children: [
        SizedBox(
            height: 24,
            width: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: '${TTexts.iAgreeTo} ',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
            text: TTexts.privacyPolicy,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
              color: (dark) ? TColors.white : TColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: (dark) ? TColors.white : TColors.primary,
            ),
          ),
          TextSpan(
            text: ' ${TTexts.and} ',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
            text: TTexts.termsOfUse,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
              color: (dark) ? TColors.white : TColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: (dark) ? TColors.white : TColors.primary,
            ),
          ),
        ])),
      ],
    );
  }
}
