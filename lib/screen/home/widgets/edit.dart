import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student_database/functions/db_functions.dart';
import 'package:student_database/models/data_model.dart';
import 'package:student_database/screen/home/widgets/screen_home.dart';

class EditPage extends StatefulWidget {
  EditPage({super.key, required this.passValue1, required this.index});
  var index;
  StudentModel passValue1;
  @override
  State<EditPage> createState() => _EditPage();
}

class _EditPage extends State<EditPage> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _numberController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String? imagepath;
//***************************************widgets**********************************************\\
//textform
  Widget textform(
      {required TextEditingController mycontroller, required String hintname}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
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

//cicleavtar

  Widget circleavatar() {
    return CircleAvatar(
      backgroundImage: imagepath == null
          ? const AssetImage('Asset/image/download.png') as ImageProvider
          : FileImage(File(imagepath!)),
      radius: 80.0,
    );
  }

//positioned
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

//elevatedbutton
  Widget elevatedbutton(
      {required void Function() onpress,
      required Icon myicon,
      required String mytext,
      required Color buttoncolor}) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttoncolor),
      ),
      onPressed: onpress,
      icon: myicon,
      label: Text(mytext),
    );
  }

//divider
  Widget divider = const SizedBox(
    height: 20,
  );
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
        child: Column(
          children: [
            const SizedBox(height: 80),
            Column(
              children: [
                circleavatar(),
                position(),
              ],
            ),
            textform(
                mycontroller: _nameController,
                hintname: widget.passValue1.name),
            divider,
            textform(
                mycontroller: _ageController, hintname: widget.passValue1.age),
            divider,
            textform(
                mycontroller: _numberController,
                hintname: widget.passValue1.number),
            divider,
            elevatedbutton(
              buttoncolor: Colors.teal,
              mytext: 'savee',
              myicon: const Icon(Icons.save_alt),
              onpress: () {
                onAddStudentButtonClicked(widget.index);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => const ScreenHome()),
                    (route) => false);
              },
            ),
            const SizedBox(height: 30),
            elevatedbutton(
              buttoncolor: Colors.red,
              mytext: 'Exit',
              myicon: const Icon(Icons.exit_to_app),
              onpress: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(int index) async {
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
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(index, _student);
    getAllStudent();
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
