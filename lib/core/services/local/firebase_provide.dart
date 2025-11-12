import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/features/authentication/data/models/doctor_model.dart';
import 'package:se7ety/features/authentication/data/models/patient_model.dart';

class FirebaseProvider {
  static final fireBaseFirestore = FirebaseFirestore.instance;

  static final CollectionReference doctorCollection = fireBaseFirestore
      .collection('doctors');

      static final CollectionReference patientCollection = fireBaseFirestore
      .collection('patients');

static void createDoctor(DoctorModel doctor){
  doctorCollection.doc(doctor.uid).set(doctor.toJson());
}

static void createPatient(PatientModel patient){
  patientCollection.doc(patient.uid).set(patient.toJson());
}

static getDoctorById(String id){
  return doctorCollection.doc(id).get();
}

static getPatientById(String id){
  return patientCollection.doc(id).get();
}

}
