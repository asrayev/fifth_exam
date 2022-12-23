import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifth_exam/data/reopository/student_repository.dart';
import 'package:fifth_exam/ui/main_page.dart';
import 'package:fifth_exam/view_model/student_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var fireStore = FirebaseFirestore.instance;


  runApp(

        MultiProvider(
            providers: [
               ChangeNotifierProvider(create: (context) => StudentViewModel(studentRepository:  StudentRepository(firebaseFirestore: fireStore))),

            ],
            child:
            MyApp(),)
      );
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
      designSize: const Size(423.5294,843.13727),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext contex, Widget? child) {
        return  MaterialApp(

          debugShowCheckedModeBanner: false,
          home: MainPage(),
        );
      },
    );
  }
}