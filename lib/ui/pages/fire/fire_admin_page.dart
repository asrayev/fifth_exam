import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:fifth_exam/data/models/student_model.dart';
import 'package:fifth_exam/utils/my_colors.dart';
import 'package:fifth_exam/view_model/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../data/service/file_uploader.dart';

class FireAdminPage extends StatefulWidget {
  const FireAdminPage({Key? key}) : super(key: key);

  @override
  State<FireAdminPage> createState() => _FireAdminPageState();
}
class _FireAdminPageState extends State<FireAdminPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String imageUrl = "";
  bool isLoading = false;
  List<dynamic> images = [];
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 70),
              Container(
                width: 150,
                height: 150,
                decoration:  BoxDecoration(borderRadius: BorderRadius.circular(75),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                  imageUrl.isEmpty
                      ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/exam-94b9c.appspot.com/o/images%2Fscaled_image_picker3160133747352040418.jpg?alt=media&token=a088d001-f89c-4190-8204-e83792b561cc")
                      : NetworkImage(
                    imageUrl,


                  )
                ),


                ),
              ),
            SizedBox(height: 15,),
            InkWell(
              onTap: ((){
                _showPicker(context);
              }),
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.blue,
                ),
                child: Center(child: Text("Upload Image", style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 16),)),

              ),
            ),
              SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(right: 60, left: 60),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.C_8A96A4,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(1, 1), // Shadow position
                      ),
                    ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      cursorHeight: 25,
                      cursorColor: Colors.blue,
                      validator: (value) {
                        if (value!.isEmpty) return "Enter student name";

                      },
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        height: 25.0 / 15,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: MyColors.C_1C2632),
                        hintText: "Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white.withOpacity(0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white.withOpacity(0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
              SizedBox(height: 80,),
              InkWell(
                onTap: ((){
                  if (_formKey.currentState?.validate() == true && imageUrl.isNotEmpty) {
                    context.read<StudentViewModel>().addStudent(StudentModel(studentId: "", studentName: _nameController.text, imageUrl: imageUrl));
                    showSnackBarSuccess();
                    }else {

                    }}),
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: Colors.blue,
                  ),
                  child: Center(child: Text("Add to Firebase", style: TextStyle(color: Colors.white, fontSize: 16),)),

                ),
              ),

            ]
          ),
        ),
      )
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      imageUrl = await FileUploader.imageUploader(pickedFile);
      setState(() {
        isLoading = false;
        _image = pickedFile;
      });
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploader(pickedFile);
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void showSnackBarSuccess(){
    AnimatedSnackBar.rectangle(
      'Good job bro',
      "Mail added to firebase successfuly",
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(
      context,
    );

  }
}
