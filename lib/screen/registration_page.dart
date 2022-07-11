import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registration_form/db/database_helper.dart';
import 'package:registration_form/models/user_details.dart';
import 'package:registration_form/screen/your_info_page.dart';
import 'package:registration_form/common_strings.dart';
import 'package:registration_form/widgets/common_textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

enum SingingCharacter { male, female }

class _RegistrationPageState extends State<RegistrationPage> {
  SingingCharacter? _character = SingingCharacter.male;
  TextEditingController firstC = TextEditingController();
  TextEditingController lastC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();

  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    CommonString.registrationHeading,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
                      ),
                      Positioned(
                        right: -10,
                        top: 30,
                        child: IconButton(
                          onPressed: () async{
                            image = await picker.pickImage(source: ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(
                      userInput: firstC,
                      commonIcon: Icons.account_circle_sharp,
                      CommonString.firstName,
                      CommonString.textFieldLabelFirstName),
                  CommonTextField(
                      userInput: lastC,
                      commonIcon: Icons.account_circle_sharp,
                      CommonString.lastName,
                      CommonString.textFieldLabelLastName),
                  CommonTextField(
                      userInput: phoneC,
                      commonIcon: Icons.phone,
                      CommonString.phoneNumber,
                      CommonString.textFieldLabelPhoneNumber),
                  CommonTextField(
                      userInput: emailC,
                      commonIcon: Icons.email,
                      CommonString.emailAddress,
                      CommonString.textFieldLabelEmailAddress),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gender",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        )),
                  ),
                  Row(
                    children: [
                      Radio<SingingCharacter>(
                        value: SingingCharacter.male,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      const Text('Male'),
                      const SizedBox(
                        width: 10,
                      ),
                      Radio<SingingCharacter>(
                        value: SingingCharacter.female,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      const Text('Female')
                    ],
                  ),
                  CommonTextField(
                      userInput: passwordC,
                      commonIcon: Icons.email,
                      CommonString.password,
                      CommonString.textFieldLabelPassword),
                  CommonTextField(
                      userInput: passwordConfirmController,
                      commonIcon: Icons.email,
                      CommonString.confirmPassword,
                      CommonString.textFieldLabelConfirmPassword),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: TextButton(
                          onPressed: () {
                            UserDetails userD =  UserDetails(firstName: firstC.text,
                                lastName: lastC
                                    .text,
                                phoneNumber: phoneC.text,
                                emailAddress: emailC.text,
                                password: passwordConfirmController.text,
                            gender: _character.toString());

                            if (formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text('Processing Data')),
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => YourInfoPage(
                                      userDetails: userD,
                                    )),
                              );
                            }





                            // dbHelper.create(userD);
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
