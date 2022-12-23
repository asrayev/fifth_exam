import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class StudentRepository {
  final FirebaseFirestore _firestore;

  StudentRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addStudent({required StudentModel studentModel}) async {
    try {
      DocumentReference newStudent =
      await _firestore.collection("students").add(studentModel.toJson());
      await _firestore.collection("students").doc(newStudent.id).update({
        "studentId": newStudent.id,
      });
      // MyUtils.getMyToast(message: "Category added successfully");
    } on FirebaseException catch (er) {
      // MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> deleteStudent({required String docId}) async {
    try {
      await _firestore.collection("students").doc(docId).delete();
      // MyUtils.getMyToast(message: "Kategorya muvaffaqiyatli o'chirildi!");
    } on FirebaseException catch (er) {
      // MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> updateStudent({required StudentModel studentModel}) async {
    try {
      await _firestore
          .collection("students")
          .doc(studentModel.studentId)
          .update(studentModel.toJson());

      // MyUtils.getMyToast(message: "Kategorya muvaffaqiyatli yangilandi!");
    } on FirebaseException catch (er) {
      // MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Stream<List<StudentModel>> getStudents() =>
      _firestore.collection("students").snapshots().map(
            (event1) => event1.docs
            .map((doc) => StudentModel.fromJson(doc.data()))
            .toList(),
      );
}