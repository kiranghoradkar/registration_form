import 'package:flutter/material.dart';
import 'package:registration_form/db/database_helper.dart';
import 'package:registration_form/models/user_details.dart';

class UserDataProvider with ChangeNotifier{
  List<UserDetails>? userDetails;
  final dbHelper = DataBaseHelper.instance;

  bool loading = false;

  getPostData() async {
    loading = true;
    userDetails = await dbHelper.readAllUser();
    loading = false;
    notifyListeners();
  }
}