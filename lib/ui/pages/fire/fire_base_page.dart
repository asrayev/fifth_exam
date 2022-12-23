import 'package:fifth_exam/ui/pages/fire/widget/slide_menu_widget.dart';
import 'package:fifth_exam/utils/my_colors.dart';
import 'package:fifth_exam/view_model/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'fire_admin_page.dart';

class FireBasePage extends StatelessWidget {
  const FireBasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.C_0F1620,
        actions: [
          InkWell(
              onTap: ((){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FireAdminPage()));
              }),
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(child: Text("Admin", style: GoogleFonts.lalezar(color: Colors.white, fontSize: 20))),
              )),
        ],
      ),
      body: Consumer<StudentViewModel>(
        builder: (context, studentViewModel, child) {
          return ListView.builder(
              itemCount: studentViewModel.students.length,
              itemBuilder: (context, index){
                var student = studentViewModel.students[index];
            return Padding(
              padding: EdgeInsets.only(right: 10),
              child: SlideMenu(
                     menuItems: [
                       Container(
                         color: Colors.black12,
                         child: IconButton(
                           icon: const Icon(Icons.edit),
                           onPressed: () {},
                         ),
                       ),
                       Container(
                         color: Colors.red,
                         child: IconButton(
                           color: Colors.white,
                           icon: const Icon(Icons.delete),
                           onPressed: () {
                             context.read<StudentViewModel>().deleteStudent(student.studentId);
                             //           .read<ProductViewModel>()
                             //           .deleteProduct(student.studentId);
                             //       print("DELETING ID:${student.studentId}");
                             
                           },
                         ),
                       ),
                     ]

              ,
                child: Container(
                  margin: const EdgeInsets.only( left: 15, top: 10),
                  height: MediaQuery.of(context).size.height*0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.C_1C2632,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width*0.11,
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(student.imageUrl.toString())
                              )
                          ),

                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                        Text(student.studentName, style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w800),),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });

            ListView(
            children: List.generate(studentViewModel.students.length, (index) {
              var student = studentViewModel.students[index];
              return ListTile(
                title: Text(student.studentName),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => UpdateProductScreen(
                      //             studentModel: student,
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     icon: const Icon(Icons.edit)),
                      // IconButton(
                      //     onPressed: () {
                      //       context
                      //           .read<ProductViewModel>()
                      //           .deleteProduct(student.studentId);
                      //       print("DELETING ID:${student.studentId}");
                      //     },
                      //     icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),

    );
  }
}
