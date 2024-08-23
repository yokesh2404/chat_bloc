import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/components/app_text_field.dart';
import 'package:state_management/screens/register/bloc/register_bloc.dart';
import 'package:state_management/utils/contants/app_colors.dart';
import 'package:state_management/utils/contants/app_sizes.dart';
import 'package:state_management/utils/contants/app_strings.dart';
import 'package:state_management/utils/helper/functions_helper.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/widgets/button_widget.dart';
import 'package:state_management/widgets/gradient_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
          onPopInvoked: (didPop) {
            if (!didPop) {
              NavigationHelper.pop();
            }
          },
          canPop: false,
          child: BlocProvider(
            create: (context) => RegisterBloc(),
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {},
              builder: (BuildContext context, RegisterState state) {
                var bloc = context.read<RegisterBloc>();
                return Column(
                  children: [
                    GradientBackground(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              GestureDetector(
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColors.white,
                                  size: AppSizes.size_24,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(AppStrings.register,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.white,
                                          fontSize: AppSizes.size_24))
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(AppStrings.createYourAccount,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: AppColors.grey, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.height_24,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppSizes.size_12),
                        child: Column(
                          children: [
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    AppTextFormField(
                                      autofocus: false,
                                      labelText: AppStrings.name,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (value) =>
                                          _formKey.currentState?.validate(),
                                      validator: (value) {
                                        return value!.isEmpty
                                            ? AppStrings.pleaseEnterName
                                            : value.length < 4
                                                ? AppStrings.invalidName
                                                : null;
                                      },
                                      controller: nameController,
                                    ),
                                    AppTextFormField(
                                      labelText: AppStrings.email,
                                      controller: emailController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (_) =>
                                          _formKey.currentState?.validate(),
                                      validator: (value) {
                                        return value!.isEmpty
                                            ? AppStrings.pleaseEnterEmailAddress
                                            : FunctionsHelper.getInstance
                                                    .validateEmailForm(value)
                                                ? null
                                                : AppStrings
                                                    .invalidEmailAddress;
                                      },
                                    ),
                                    AppTextFormField(
                                      obscureText: bloc.isShowPassword,
                                      controller: passwordController,
                                      labelText: AppStrings.password,
                                      textInputAction: TextInputAction.next,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      onChanged: (_) =>
                                          _formKey.currentState?.validate(),
                                      validator: (value) {
                                        return value!.isEmpty
                                            ? AppStrings.pleaseEnterPassword
                                            : FunctionsHelper.getInstance
                                                    .isStrongPassword(value)
                                                ? null
                                                : AppStrings.invalidPassword;
                                      },
                                      suffixIcon: Focus(
                                        /// If false,
                                        ///
                                        /// disable focus for all of this node's descendants
                                        descendantsAreFocusable: false,

                                        /// If false,
                                        ///
                                        /// make this widget's descendants un-traversable.
                                        // descendantsAreTraversable: false,
                                        child: IconButton(
                                          onPressed: () {
                                            bloc.add(ShowPasswordEvent());
                                          },
                                          style: IconButton.styleFrom(
                                            minimumSize: const Size.square(48),
                                          ),
                                          icon: Icon(
                                            bloc.isShowPassword
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AppTextFormField(
                                      labelText: AppStrings.confirmPassword,
                                      controller: confirmPasswordController,
                                      obscureText: context
                                          .read<RegisterBloc>()
                                          .isShowConfirmPassword,
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      onChanged: (_) =>
                                          _formKey.currentState?.validate(),
                                      validator: (value) {
                                        return value!.isEmpty
                                            ? AppStrings.pleaseReEnterPassword
                                            : FunctionsHelper.getInstance
                                                    .isStrongPassword(value)
                                                ? passwordController.text ==
                                                        confirmPasswordController
                                                            .text
                                                    ? null
                                                    : AppStrings
                                                        .passwordNotMatched
                                                : AppStrings.invalidPassword;
                                      },
                                      suffixIcon: Focus(
                                        descendantsAreFocusable: false,
                                        child: IconButton(
                                          onPressed: () {
                                            bloc.add(
                                                ShowConfirmPasswordEvent());
                                          },
                                          style: IconButton.styleFrom(
                                            minimumSize: const Size.square(48),
                                          ),
                                          icon: Icon(
                                            bloc.isShowConfirmPassword
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
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
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    bloc.add(FormDataStoreEvent(context,
                                        userName: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text));
                                  }
                                },
                                buttonText: AppStrings.register),
                            SizedBox(
                              height: AppSizes.height_100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.iHaveAnAccount,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.black),
                                ),
                                TextButton(
                                  onPressed: () => NavigationHelper.pop(),
                                  child: const Text(AppStrings.login),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          )),
    );
  }
}
