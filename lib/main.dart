import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_database/models/data_model.dart';
import 'package:student_database/screen/home/widgets/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Montserrat'),
      home: const ScreenHome(),
    );
  }
}
