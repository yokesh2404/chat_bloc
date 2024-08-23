import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:state_management/components/app_text_field.dart';
import 'package:state_management/repositories/firebase_repo/firebase_repo.dart';
import 'package:state_management/screens/login/bloc/login_bloc.dart';
import 'package:state_management/utils/contants/app_colors.dart';
import 'package:state_management/utils/contants/app_images.dart';
import 'package:state_management/utils/contants/app_sizes.dart';
import 'package:state_management/utils/contants/app_strings.dart';
import 'package:state_management/utils/helper/functions_helper.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/utils/helper/route_helper.dart';
import 'package:state_management/widgets/button_widget.dart';
import 'package:state_management/widgets/gradient_widget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogInScreenState();
  }
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    // context.read<LoginBloc>().add(LoginInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(FirebaseAuthService()),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {},
          builder: (BuildContext context, LoginState state) {
            return Column(
              children: [
                GradientBackground(
                  children: [
                    Text(
                      AppStrings.signInToYourNAccount,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.white, fontSize: AppSizes.size_24),
                    ),
                    const SizedBox(height: AppSizes.size_06),
                    Text(AppStrings.signInToYourAccount,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.grey)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Form(
                            key: loginFormKey,
                            child: Column(
                              children: [
                                AppTextFormField(
                                  controller: emailController,
                                  labelText: AppStrings.email,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (_) =>
                                      loginFormKey.currentState?.validate(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.pleaseEnterEmailAddress;
                                    } else if (value.isNotEmpty &&
                                        !FunctionsHelper.getInstance
                                            .validateEmailForm(value)) {
                                      return AppStrings.invalidEmailAddress;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                AppTextFormField(
                                  obscureText:
                                      context.read<LoginBloc>().isShowPassword,
                                  controller: passController,
                                  labelText: AppStrings.password,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (_) =>
                                      loginFormKey.currentState?.validate(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.pleaseEnterPassword;
                                    } else if (value.isNotEmpty &&
                                        !FunctionsHelper.getInstance
                                            .isStrongPassword(value)) {
                                      return AppStrings.invalidPassword;
                                    }
                                    return null;
                                  },
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      context
                                          .read<LoginBloc>()
                                          .add(ShowPasswordEvent());
                                    },
                                    style: IconButton.styleFrom(
                                      minimumSize: const Size.square(48),
                                    ),
                                    icon: Icon(
                                      context.read<LoginBloc>().isShowPassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(AppStrings.forgotPassword),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ButtonWidget(
                            height: AppSizes.height_48,
                            borderRadius: AppSizes.size_10,
                            backgroundColor: AppColors.secondary,
                            borderColor: AppColors.secondary,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.black),
                            onClick: () {
                              if (loginFormKey.currentState!.validate()) {
                                loginFormKey.currentState!.save();
                                context.read<LoginBloc>().add(SumbitLogin(
                                    context,
                                    email: emailController.text,
                                    password: passController.text));
                              }
                            },
                            buttonText: AppStrings.login),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(color: Colors.grey.shade400)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                AppStrings.orLoginWith,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                            Expanded(
                                child: Divider(color: Colors.grey.shade400)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(AppImages.googleSvg,
                                    width: 14),
                                label: const Text(
                                  AppStrings.google,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(AppImages.facebookSvg,
                                    width: 14),
                                label: const Text(
                                  AppStrings.facebook,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.doNotHaveAnAccount,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.black),
                            ),
                            const SizedBox(width: 4),
                            TextButton(
                              onPressed: () {
                                NavigationHelper.pushNamed(
                                    RouteHelper.register);
                              },
                              child: const Text(AppStrings.register),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
            // final bloc = context.read<LoginBloc>();
            // if (state is LoadingState) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            // return SingleChildScrollView(
            //   padding: const EdgeInsets.all(12),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Text("Log in"),
            //       const SizedBox(
            //         height: 12,
            //       ),
            // ,
            //       const SizedBox(
            //         height: 24,
            //       ),
            //       MaterialButton(
            //         onPressed: () {
            //           if (loginFormKey.currentState!.validate()) {
            //             loginFormKey.currentState!.save();
            //             context.read<LoginBloc>().add(SumbitLogin(
            //                 email: emailController.text,
            //                 password: passController.text));
            //           }
            //         },
            //         color: Colors.green,
            //         child: Text("Submit"),
            //       )
            //     ],
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
