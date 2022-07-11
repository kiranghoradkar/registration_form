const String userTable = "user";

class UserFields {
  static final List<String> values = [
    id,
    firstName,
    lastName,
    phoneNumber,
    emailAddress,
    gender,
    education,
    passingYear,
    percentage,
    experience,
    designation,
    address,
    state,
    password
  ];

  static const String id = '_id';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String phoneNumber = 'phoneNumber';
  static const String emailAddress = 'emailAddress';
  static const String gender = 'gender';
  static const String education = 'education';
  static const String passingYear = 'passingYear';
  static const String percentage = 'percentage';
  static const String experience = 'experience';
  static const String designation = 'designation';
  static const String address = 'address';
  static const String state = 'state';
  static const String password = 'password';
}

class UserDetails {
   int? id;
   String? firstName;
   String? lastName;
   String? phoneNumber;
   String? emailAddress;
   String? gender;
   String? education;
   String? passingYear;
   String? percentage;
   String? experience;
   String? designation;
   String? address;
   String? state;
   String? password;

   UserDetails(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.emailAddress,
      this.gender,
      this.education,
      this.passingYear,
      this.percentage,
      this.experience,
      this.designation,
      this.address,
      this.state,
        this.password,});

  static UserDetails fromJson(Map<String, Object?> json) => UserDetails(
    id: json[UserFields.id] as int,
    firstName: json[UserFields.firstName] as String?,
    lastName: json[UserFields.lastName] as String?,
    phoneNumber: json[UserFields.phoneNumber] as String?,
    emailAddress: json[UserFields.emailAddress] as String?,
    gender: json[UserFields.gender] as String?,
    education: json[UserFields.education] as String?,
    passingYear: json[UserFields.passingYear] as String?,
    percentage: json[UserFields.percentage] as String?,
    experience: json[UserFields.experience] as String?,
    designation: json[UserFields.designation] as String?,
    address: json[UserFields.address] as String?,
    state: json[UserFields.state] as String?,
    password: json[UserFields.password] as String?,
  );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.firstName: firstName,
        UserFields.lastName: lastName,
        UserFields.phoneNumber: phoneNumber,
        UserFields.emailAddress: emailAddress,
        UserFields.gender: gender,
        UserFields.education: education,
        UserFields.passingYear: passingYear,
        UserFields.percentage: percentage,
        UserFields.experience: experience,
        UserFields.designation: designation,
        UserFields.address: address,
        UserFields.state: state,
        UserFields.password: password,
      };
}
