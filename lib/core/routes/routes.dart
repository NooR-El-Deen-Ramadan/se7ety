import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/authentication/data/models/user_type_enum.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:se7ety/features/authentication/presentation/pages/login_screen.dart';
import 'package:se7ety/features/authentication/presentation/pages/register_screen.dart';
import 'package:se7ety/features/intro/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:se7ety/features/intro/spalsh/pages/splash_screen.dart';
import 'package:se7ety/features/intro/welcome/pages/welcome_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static const String splash = "/";
  static const String onBoarding = "/onBoarding";
  static const String welcome = "/welcome";

  static const String login = "/login";
  static const String register = "/register";
  static const String forgetPassword = "/forgetPassword";
  static const String otp = "/otp";
  static const String changePassword = "/changePassword";
  static const String passwordResetSuccess = "/passwordResetSuccess";
  static const String main = "/main";
  static const String bookDetails = "/bookDetails";
  static const String placeOrder = "/placeOrder";
  static const String success = "/success";
  static const String editProfile = "/editProfile";

  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: LoginScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: RegisterScreen(userType: state.extra as UserTypeEnum),
        ),
      ),

      //     GoRoute(
      //       path: forgetPassword,
      //       builder: (context, state) => ForgetPasswordScreen(),
      //     ),
      //     GoRoute(path: otp, builder: (context, state) => OtpScreen()),
      //     GoRoute(
      //       path: changePassword,
      //       builder: (context, state) => CreateNewPasswordScreen(),
      //     ),
      //     GoRoute(
      //       path: passwordResetSuccess,
      //       builder: (context, state) => PasswordResetSuccessScreen(),
      //     ),
      //     GoRoute(path: main, builder: (context, state) => MainScreen()),
      //     GoRoute(
      //       path: bookDetails,
      //       builder: (context, state) {
      //         var args = state.extra as Map<String, dynamic>;
      //         return BlocProvider(
      //           create: (context) => HomeCubit(),
      //           child: BookDetailsScreen(
      //             product: args["data"] as Product,
      //             source: args["source"] as String,
      //           ),
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       path: placeOrder,
      //       builder: (context, state) {
      //         return BlocProvider(
      //           create: (context) => CartCubit()..initData(),
      //           child: PlaceOrderScreen(totalPrice: state.extra as String),
      //         );
      //       },
      //     ),
      //     GoRoute(path: success, builder: (context, state) => SuccessScreen()),
      //     GoRoute(
      //       path: editProfile,
      //       builder: (context, state) => BlocProvider(
      //         create: (context) => ProfileCubit()..initData(),
      //         child: EditProfileScreen(),
      //       ),
      //     ),
    ],
  );
}
