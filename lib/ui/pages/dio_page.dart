import 'package:fifth_exam/data/reopository/users_repository.dart';
import 'package:fifth_exam/data/service/api_service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/my_colors.dart';
import '../../view_model/users_view_model.dart';

class DioPage extends StatelessWidget {
  const DioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context)=> UserViewModel(userRepository: UserRepository(apiService: ApiService())),
        child:  Consumer<UserViewModel>(
          builder: (context, userViewModel, child) {
            return ListView.builder(
                itemCount: userViewModel.userModel!.length,
                itemBuilder: (context, index){
                  var user = userViewModel.userModel![index];
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
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
                                        image: NetworkImage(user.avatarUrl.toString())
                                    )
                                ),

                              ),
                              SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                              Column(
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                                  Text(user.username.toString(), style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w800),),
                                  Text(user.name.toString(), style: GoogleFonts.raleway(color: Colors.grey,fontSize: 14.sp),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                  );
                });

         }
       ),
      )
    );
  }
}
