import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_form/db/database_helper.dart';
import 'package:registration_form/models/user_details.dart';
import 'package:registration_form/screen/registration_page.dart';
import 'package:registration_form/common_strings.dart';
import 'package:registration_form/user_data_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DataBaseHelper.instance;

  @override
  void initState() {
    final postMdl = context.read<UserDataProvider>();
    postMdl.getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserDataProvider>(builder: (_, postMdl, child) {
        return postMdl.loading
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: postMdl.userDetails?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerLeft,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Name: ${postMdl.userDetails![index].firstName!} ${postMdl.userDetails![index].lastName!}"),
                              Text(
                                  "Phone number: ${postMdl.userDetails![index].phoneNumber!}"),
                              Text(
                                  "Email address: ${postMdl.userDetails![index].emailAddress!}"),
                              Text(
                                  "Education: ${postMdl.userDetails![index].education!}"),
                              Text(
                                  "Passing year: ${postMdl.userDetails![index].passingYear!}"),
                              Text(
                                  "Experience: ${postMdl.userDetails![index].experience!}"),
                              Text(
                                  "Designation: ${postMdl.userDetails![index].designation!}"),
                              Text(
                                  "Address: ${postMdl.userDetails![index].address!}"),
                              Text(
                                  "State: ${postMdl.userDetails![index].state!}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
      }),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegistrationPage()),
            );

            if (result != null) {
              context.read<UserDataProvider>().getPostData();
            }
          },
          child: const Text(
            CommonString.registrationHeading,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
