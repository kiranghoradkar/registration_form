import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

  File? imgFile;

  Uint8List? bytes;

  Future<Uint8List?>? result;

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
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: bytes != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.memory(
                                  bytes!,
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(60)),
                              ),
                      ),
                      Positioned(
                        right: 0,
                        top: 50,
                        child: InkWell(
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(25)),
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 22,
                              )),
                          onTap: () async {
                            image = await picker.pickImage(
                                source: ImageSource.gallery);

                            imgFile = File(image!.path);
                            bytes = await FlutterImageCompress.compressWithFile(
                              image!.path,
                              minWidth: 1000,
                              minHeight: 1000,
                              quality: 80,
                              rotate: 0,
                            );

                            setState(() {});
                          },
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
                            UserDetails userD = UserDetails(
                                profilePic: bytes,
                                firstName: firstC.text,
                                lastName: lastC.text,
                                phoneNumber: phoneC.text,
                                emailAddress: emailC.text,
                                password: passwordConfirmController.text,
                                gender: _character.toString());

                            if (formKey.currentState!.validate()) {
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
