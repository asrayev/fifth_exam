
import 'package:fifth_exam/ui/pages/animation_page.dart';
import 'package:fifth_exam/ui/pages/dio_page.dart';
import 'package:fifth_exam/ui/pages/fire/fire_base_page.dart';
import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}
int currentPage=0;
class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    List pages=[
      FireBasePage(),
      DioPage(),
      AnimationPage()
    ];
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (v){
          setState(() {currentPage=v;});
        },
        backgroundColor: MyColors.C_0F1620,
        unselectedItemColor: MyColors.C_938F88,
        selectedItemColor: MyColors.C_46AEF5,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.local_fire_department),label: "Firebase"),
          BottomNavigationBarItem(icon: Icon(Icons.looks_two),label: "Dio"),
          BottomNavigationBarItem(icon: Icon(Icons.three_k_outlined),label: "Animation"),


        ],
      ),
    );
  }
  Color colorGenerator(int number){
    return currentPage==number? MyColors.C_46AEF5 : MyColors.C_938F88;
  }
}


