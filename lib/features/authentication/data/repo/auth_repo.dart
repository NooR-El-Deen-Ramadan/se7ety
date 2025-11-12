import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7ety/core/services/local/firebase_provide.dart';
import 'package:se7ety/features/authentication/data/models/doctor_model.dart';
import 'package:se7ety/features/authentication/data/models/patient_model.dart';
import 'package:se7ety/features/authentication/data/models/user_type_enum.dart';

class AuthRepo {
  static Future<Either<String, UserTypeEnum>> register({
    required String userName,
    required String email,
    required String password,
    required UserTypeEnum userType,
  }) async {
    try {
      var userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredentials.user!;
      user.updateDisplayName(userName);

      if (userType == UserTypeEnum.doctor) {
        user.updatePhotoURL('2');
        var doctor = DoctorModel(uid: user.uid, email: email, name: userName);
        FirebaseProvider.createDoctor(doctor);
      } else {
        user.updatePhotoURL('1');
        var patient = PatientModel(uid: user.uid, email: email, name: userName);
        FirebaseProvider.createPatient(patient);
      }

      return Right(userType);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(
          'كلمة المرور ضعيفة للغاية.',
        ); //('كلمة المرور ضعيفة للغاية.'));
      } else if (e.code == 'email-already-in-use') {
        return Left('هذا البريد الإلكتروني مستخدم بالفعل.');
      } else {
        return Left('حدث خطأ أثناء التسجيل.');
      }
    } catch (e) {
      return Left("حدث خطأ ما. يرجى المحاولة مرة أخرى.");
    }
  }

  static Future<Either<String, UserTypeEnum>> login({
    required String email,
    required String password,
  }) async {
    try {
      var credentilas = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credentilas.user!;
      if (user.photoURL == '2') {
        return Right(UserTypeEnum.doctor);
      } else {
        return Right(UserTypeEnum.patient);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left('لم يتم العثور على مستخدم بهذا البريد الإلكتروني.');
      } else if (e.code == 'wrong-password') {
        return Left('كلمة المرور غير صحيحة.');
      } else {
        return Left('حدث خطأ أثناء تسجيل الدخول.');
      }
    } catch (e) {
      return Left("حدث خطأ ما. يرجى المحاولة مرة أخرى.");
    }
  }
}
