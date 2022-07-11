import 'package:flutter/material.dart';
import 'package:registration_form/models/user_details.dart';
import 'package:registration_form/screen/address_page.dart';
import 'package:registration_form/common_strings.dart';
import 'package:registration_form/widgets/common_dropdown.dart';
import 'package:registration_form/widgets/common_textfield.dart';

class YourInfoPage extends StatefulWidget {
  final UserDetails userDetails;

  const YourInfoPage({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<YourInfoPage> createState() => _YourInfoPageState();
}

class _YourInfoPageState extends State<YourInfoPage> {
  List<String> educationList = ['SSC', 'HSC', 'GRADUATION', 'POST-GRADUATION'];
  List<String> yearOfPassing = ['2019', '2020', '2021', '2022'];
  List<String> designationList = [
    'Software engineer',
    'Team lead',
    'Product manager',
    'Reporting manager'
  ];
  TextEditingController gradeC = TextEditingController();
  TextEditingController experianceC = TextEditingController();
  String? selectedEducation;
  String? selectedPassingYr;
  String? selectedDesig;
  final dropDownKey = GlobalKey<FormState>();

  @override
  void initState() {
    String? gend = widget.userDetails.gender;
    List<String>? temp = gend?.split('.');
    String? finalGender = temp?[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          CommonString.yourInfo,
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Form(
        key: dropDownKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(17, 4, 10, 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    CommonString.eduInfo,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CommonDropDown(
                educationList,
                CommonString.education,
                callback: (String value) {
                  selectedEducation = value;
                  debugPrint(selectedEducation);
                },
              ),
              CommonDropDown(
                yearOfPassing,
                CommonString.passingYr,
                callback: (String value) {
                  selectedPassingYr = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
                child: CommonTextField(
                    userInput: gradeC,
                    CommonString.gradeLabel,
                    CommonString.grade),
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 4, 4, 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Professional Ifo",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
                child: CommonTextField(
                    userInput: experianceC,
                    CommonString.experiance,
                    CommonString.experianceLabel),
              ),
              CommonDropDown(
                designationList,
                CommonString.designation,
                callback: (String value) {
                  selectedDesig = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 150,
                      color: Colors.black12,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Previous'))),
                  Container(
                    width: 150,
                    color: Colors.green[200],
                    child: TextButton(
                        onPressed: () {
                          widget.userDetails.education = selectedEducation;
                          widget.userDetails.passingYear = selectedPassingYr;
                          widget.userDetails.percentage = gradeC.text;
                          widget.userDetails.experience = experianceC.text;
                          widget.userDetails.designation = selectedDesig;

                          if (dropDownKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddressPage(widget.userDetails)),
                            );
                          }
                        },
                        child: const Text('Next',)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
