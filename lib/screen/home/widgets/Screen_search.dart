import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_database/screen/home/widgets/screen_details.dart';

import '../../../models/data_model.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  List<StudentModel> studentlist =
      Hive.box<StudentModel>('student_db').values.toList();
  late List<StudentModel> studentlistDisplay =
      List<StudentModel>.from(studentlist);
  final _searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            textform(),
            expanded(),
          ],
        ),
      ),
    );
  }

  void _searchStudent(String value) {
    setState(() {
      studentlistDisplay = studentlist
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void cleartext() {
    _searchcontroller.clear();
  }

  Widget textform() {
    return TextFormField(
      autofocus: true,
      controller: _searchcontroller,
      decoration: InputDecoration(
          hintText: 'search',
          contentPadding: const EdgeInsets.all(20.0),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              onPressed: () {
                cleartext();
              },
              icon: const Icon(Icons.clear))),
      textAlign: TextAlign.center,
      onChanged: (value) {
        _searchStudent(value);
      },
    );
  }

  Widget expanded() {
    return Expanded(
      child: studentlistDisplay.isNotEmpty
          ? ListView.builder(
              itemCount: studentlistDisplay.length,
              itemBuilder: (context, index) {
                //   key: ValueKey(studentlistDisplay[index].name),
                File img = File(studentlistDisplay[index].image);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(img),
                  ),
                  title: Text(
                    studentlistDisplay[index].name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (ctx) => ScreenDetails(
                              passindex: index,
                              passvalue: studentlistDisplay[index],
                            )),
                  ),
                );
              })
          : const Text(
              ' No results found',
              style: TextStyle(fontSize: 15),
            ),
    );
  }
}
