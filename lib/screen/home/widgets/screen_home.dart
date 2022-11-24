import 'package:flutter/material.dart';

import 'package:student_database/screen/home/widgets/add_students_widget.dart';
import 'package:student_database/screen/home/widgets/list_student_widget.dart';

import '../../../functions/db_functions.dart';
import 'Screen_search.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 16, 16, 17),
                Color.fromARGB(255, 47, 184, 234)
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenSearch(),
                  ));
            },
          )
        ],
      ),
      body: ListStudentWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(context, null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showForm(BuildContext context, var itemkey, var index) {
  showModalBottomSheet(
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (_) => const AddStudentWidget(),
  );
}
