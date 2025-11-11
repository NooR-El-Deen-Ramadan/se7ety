import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/authentication/data/models/doctor_model.dart';
import 'package:se7ety/features/authentication/data/models/patient_model.dart';
import 'package:se7ety/features/authentication/data/models/user_type_enum.dart';
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
    try {
      var userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordCController.text,
          );
      User user = userCredentials.user!;
      user.updateDisplayName(userNameController.text);

      if (event.userType == UserTypeEnum.doctor) {
        var doctor = DoctorModel(
          uid: user.uid,
          email: emailController.text,
          name: userNameController.text,
        );
        FirebaseFirestore.instance
            .collection('doctors')
            .doc(user.uid)
            .set(doctor.toJson());
      } else {
        var patient = PatientModel(
          uid: user.uid,
          email: emailController.text,
          name: userNameController.text,
        );
        FirebaseFirestore.instance
            .collection('patients')
            .doc(user.uid)
            .set(patient.toJson());
      }

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

  login(LoginEvent event, Emitter<AuthStates> emit) async {}
}
