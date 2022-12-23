import 'dart:async';

import 'package:fifth_exam/data/reopository/student_repository.dart';
import 'package:flutter/cupertino.dart';
import '../data/models/student_model.dart';

class StudentViewModel extends ChangeNotifier {
  final StudentRepository studentRepository;


  StudentViewModel({required this.studentRepository}) {
    listenProducts();
  }

  late StreamSubscription subscription;

  List<StudentModel> student = [];
  List<StudentModel> students = [];
  listenProducts() async {
    subscription = studentRepository
        .getStudents()
        .listen((allProducts) {
       students = allProducts;
      print("ALL PRODUCTS LENGTH:${allProducts.length}");
      student = allProducts;
      notifyListeners();
    });
  }
  Stream<List<StudentModel>> listenStudents() =>
      studentRepository.getStudents();

  addStudent(StudentModel studentModel) =>
      studentRepository.addStudent(studentModel: studentModel);

  updateStudent(StudentModel studentModel) =>
      studentRepository.updateStudent(studentModel: studentModel);

  deleteStudent(String docId) =>
      studentRepository.deleteStudent(docId: docId);
}
