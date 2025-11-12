import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/authentication/data/repo/auth_repo.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_events.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc() : super(AuthInitialState()) {
    on((event, emit) async {
      if (event is RegisterEvent) {
        await register(event, emit);
      } else if (event is LoginEvent) {
        await login(event, emit);
      }
    });
  }

  final emailController = TextEditingController();
  final passwordCController = TextEditingController();
  final userNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  register(RegisterEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoasdingState());
    var result = await AuthRepo.register(
      userName: userNameController.text,
      email: emailController.text,
      password: passwordCController.text,
      userType: event.userType,
    );

    result.fold(
      (error) {
        emit(AuthErrorState(error));
      },
      (success) {
        emit(AuthSuccessState());
      },
    );
  }

  login(LoginEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoasdingState());
    var result = await AuthRepo.login(
      email: emailController.text,
      password: passwordCController.text,
    );
    result.fold(
      (error) {
        emit(AuthErrorState(error));
      },
      (success) {
        emit(AuthSuccessState());
      },
    );
  }
}
