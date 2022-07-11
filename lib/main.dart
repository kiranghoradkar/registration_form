import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_form/models/user_details.dart';
import 'package:registration_form/screen/home_page.dart';
import 'package:registration_form/user_data_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider<UserDataProvider>(create: (_) => UserDataProvider()),
      ],
      child: const MyHomePage(title: 'Registration Form')),
    );
  }
}
