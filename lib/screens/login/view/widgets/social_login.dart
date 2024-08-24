import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:state_management/utils/contants/app_images.dart';
import 'package:state_management/utils/contants/app_strings.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade400)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.orLoginWith,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade400)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  // context
                  //     .read<LoginBloc>()
                  //     .add(GoogleSigninEvent(context: context));
                },
                icon: SvgPicture.asset(AppImages.googleSvg, width: 14),
                label: const Text(
                  AppStrings.google,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {},
                icon: SvgPicture.asset(AppImages.facebookSvg, width: 14),
                label: const Text(
                  AppStrings.facebook,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
