import 'package:flutter/material.dart';
import 'package:registration_form/db/database_helper.dart';
import 'package:registration_form/models/user_details.dart';
import 'package:registration_form/widgets/common_dropdown.dart';
import 'package:registration_form/widgets/common_textfield.dart';

class AddressPage extends StatefulWidget {
  final UserDetails userDetails;

  const AddressPage(
    this.userDetails, {
    Key? key,
  }) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<String> listOfState = [
    'UttarPradesh',
    'MadhyaPrades',
    'Maharashtra',
    'Tamilnadu'
  ];
  TextEditingController addressC = TextEditingController();
  TextEditingController landmarkC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController pincodeC = TextEditingController();
  final dbHelper = DataBaseHelper.instance;
  String? selectedState;
  final addressFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.userDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Address",
          style: TextStyle(fontSize: 28, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Form(
        key: addressFormKey,
        child: Center(
          child: Column(
            children: [
              CommonTextField(
                userInput: addressC,
                "Address",
                "Enter your address",
                commonIcon: Icons.location_on,
              ),
              CommonTextField(
                userInput: landmarkC,
                "LandMark",
                "Enter your landmark",
                commonIcon: Icons.location_city,
              ),
              CommonTextField(
                userInput: cityC,
                "City",
                "Enter your city",
                commonIcon: Icons.location_city_outlined,
              ),
              CommonDropDown(
                listOfState,
                "Select State",
                callback: (String value) {
                  selectedState = value;
                },
              ),
              CommonTextField(
                userInput: pincodeC,
                "Pincode",
                "Enter Pincode",
                commonIcon: Icons.location_city_outlined,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: TextButton(
                        onPressed: () async {
                          widget.userDetails.address = addressC.text;
                          widget.userDetails.state = selectedState;
                          if (addressFormKey.currentState!.validate()) {
                            await dbHelper.create(widget.userDetails);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
