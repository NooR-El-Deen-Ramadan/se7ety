import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_events.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>(login);
    on<RegisterEvent>(register);
  }

  final emailController = TextEditingController();
  final passwordCController = TextEditingController();
  final userNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  register(RegisterEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoasdingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordCController.text,
      );
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState('كلمة المرور ضعيفة للغاية.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState('هذا البريد الإلكتروني مستخدم بالفعل.'));
      } else {
        emit(AuthErrorState('حدث خطأ أثناء التسجيل.'));
      }
    } catch (e) {
      emit(AuthErrorState("حدث خطأ ما. يرجى المحاولة مرة أخرى."));
    }
  }

 login(LoginEvent event, Emitter<AuthStates> emit) async {

  }
}
