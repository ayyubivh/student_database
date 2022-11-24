import 'dart:io';

import 'package:flutter/material.dart';

import 'package:student_database/functions/db_functions.dart';
import 'package:student_database/screen/home/widgets/screen_details.dart';

import '../../../models/data_model.dart';

class ListStudentWidget extends StatelessWidget {
  ListStudentWidget({super.key});

  var formglobalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Container(
          color: Colors.grey.shade300,
          child: ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
              return Card(
                elevation: 5,
                shadowColor: Color.fromARGB(255, 148, 169, 164),
                child: ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: 0.9),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ScreenDetails(passvalue: data, passindex: index),
                        ));
                  },
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(data.image)),
                  ),
                  title: Text(data.name),
                  trailing: IconButton(
                    onPressed: () {
                      deleteStudent(index);
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: studentList.length,
          ),
        );
      },
    );
  }
}
