import 'dart:io';

import 'package:flutter/material.dart';

import 'package:student_database/models/data_model.dart';

import 'package:student_database/screen/home/widgets/edit.dart';

class ScreenDetails extends StatelessWidget {
  ScreenDetails({
    super.key,
    required this.passvalue,
    required this.passindex,
  });
  StudentModel passvalue;
  var passindex;
  var formglobalkey = GlobalKey<FormState>();
//*************************widgets****************************//
  Widget text({required String myname}) {
    return Text(
      myname,
      style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
    );
  }

  Widget divider = const SizedBox(
    height: 30,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Details'),
      ),
      body: Form(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              divider,
              divider,
              CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(File(passvalue.image)),
              ),
              divider,
              text(myname: 'Name:${passvalue.name}'),
              divider,
              text(myname: 'Age:${passvalue.age}'),
              divider,
              text(myname: 'Number:${passvalue.number}'),
              divider,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          _showForm(context, passvalue, passindex);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

void _showForm(BuildContext context, passvalue, passindex) {
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (_) => EditPage(passValue1: passvalue, index: passindex));
}
