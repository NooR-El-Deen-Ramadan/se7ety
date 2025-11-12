import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/components/buttons/main_button.dart';
import 'package:se7ety/core/constants/images.dart';
import 'package:se7ety/core/functions/app_regex.dart';
import 'package:se7ety/core/functions/show_dialoges.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/fonts.dart';
import 'package:se7ety/features/authentication/data/models/user_type_enum.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_events.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;

  String handleUserType() {
    return widget.userType == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        actions: [
          IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(Icons.arrow_forward, color: AppColors.primaryColor),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context: context);
          } else if (state is AuthSuccessState) {
            if (state.userType == UserTypeEnum.doctor) {
              //push to doctor home
            } else {
              //push to patient home
            }
          } else if (state is AuthErrorState) {
            pop(context);
            showDialoges(context: context, message: state.message);
            log("Registration Failed: ${state.message}");
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: bloc.formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.logoPNG, height: 250),
                    Gap(40),
                    Text(
                      'سجل دخول الان كـ "${handleUserType()}"',
                      style: AppFontStyles.title.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(30),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: bloc.emailController,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintText: 'NoorElDeen@example.com',
                        prefixIcon: Icon(Icons.email_rounded),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الايميل';
                        } else if (!AppRegex.isEmailValid(value)) {
                          return 'من فضلك ادخل الايميل صحيحا';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 25.0),
                    TextFormField(
                      textAlign: TextAlign.end,
                      style: const TextStyle(color: AppColors.darkColor),
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: '********',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                            (isVisible)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_rounded,
                          ),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      controller: bloc.passwordCController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                        return null;
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsetsDirectional.only(
                        top: 10,
                        start: 10,
                      ),
                      child: Text(
                        'نسيت كلمة السر ؟',
                        style: AppFontStyles.small.copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Gap(20),
                    MainButton(
                      onPressed: () async {
                        if (bloc.formKey.currentState!.validate()) {
                          bloc.add(
                            LoginEvent(
                              email: bloc.emailController.text,
                              password: bloc.passwordCController.text,
                              userType: widget.userType,
                            ),
                          );
                        }
                      },
                      buttonText: "تسجيل الدخول",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لدي حساب ؟',
                            style: AppFontStyles.body.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              log(widget.userType.toString());
                              pushWithReplacment(
                                context: context,
                                route: AppRouter.register,
                                extra: widget.userType,
                              );
                            },
                            child: Text(
                              'سجل الان',
                              style: AppFontStyles.body.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
