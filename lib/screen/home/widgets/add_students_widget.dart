import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student_database/functions/db_functions.dart';
import 'package:student_database/models/data_model.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _numberController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String? imagepath;
//************************widgets************************\\

//textform

  Widget textform({
    required TextEditingController mycontroller,
    required String hintname,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            controller: mycontroller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white,
              hintText: hintname,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

//elevatedbutton
  Widget elevatedbutton(
      {required void Function() onpressaction,
      required Icon myicon,
      required Text labeltext,
      required Color buttoncolor}) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttoncolor),
      ),
      onPressed: onpressaction,
      icon: myicon,
      label: labeltext,
    );
  }

//position
  Widget position() {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: InkWell(
        onTap: () {
          takePhoto();
        },
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
    );
  }

//circle Avatar
  Widget circleavtar() {
    return CircleAvatar(
      backgroundImage: imagepath == null
          ? const AssetImage('Asset/image/download.png') as ImageProvider
          : FileImage(File(imagepath!)),
      radius: 80.0,
    );
  }

//divider
  Widget divider = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //   borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color.fromARGB(255, 16, 16, 17),
            Color.fromARGB(255, 47, 184, 234)
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 80),
              circleavtar(),
              position(),
              textform(mycontroller: _nameController, hintname: 'Name'),
              divider,
              textform(mycontroller: _ageController, hintname: 'Age'),
              divider,
              textform(
                  mycontroller: _numberController, hintname: 'Roll Nunber'),
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  elevatedbutton(
                    buttoncolor: const Color.fromARGB(255, 25, 189, 34),
                    labeltext: const Text('save'),
                    myicon: const Icon(Icons.save),
                    onpressaction: () {
                      onAddStudentButtonClicked();
                      Navigator.pop(context);
                    },
                  ),
                  elevatedbutton(
                      onpressaction: () {
                        Navigator.pop(context);
                      },
                      myicon: const Icon(Icons.exit_to_app),
                      labeltext: const Text('Exit'),
                      buttoncolor: Colors.red)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _number = _numberController.text.trim();
    //  final _image = imagepath!;
    if (_name.isEmpty || _age.isEmpty || _number.isEmpty) {
      return;
    }
    print('$_name $_age');
    final _student = StudentModel(
        name: _name, age: _age, number: _number, image: imagepath!);
    addStudent(_student);
  }

  Future<void> takePhoto() async {
    // try {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagepath = PickedFile.path;
      });
    }
  }
}
