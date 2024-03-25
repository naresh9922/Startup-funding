// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter/material.dart';

// class Registration extends StatefulWidget {
//   const Registration({super.key});

//   @override
//   State<Registration> createState() => _RegistrationState();
// }

// const List<String> roles = <String>['Investor', 'Student'];

// class _RegistrationState extends State<Registration> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController experienceController = TextEditingController();
//   TextEditingController companyController = TextEditingController();
//   TextEditingController classController = TextEditingController();
//   TextEditingController rollnoController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   String selectedClass = "";
//   String selectedRole = "";
//   final TextEditingController _selectedRole = TextEditingController();
//   String dropdownValue = roles.first;
//   bool isStudent = false;
//   bool isInvestor = false;
//   bool isMentor = false; // Remove this line
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Registration"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(
//           left: 16.0,
//           right: 16,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: 8),
//                         child: CustomInput(
//                           "Full Name",
//                           nameController,
//                           TextInputType.name,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       CustomInput(
//                         "Email Id",
//                         emailController,
//                         TextInputType.emailAddress,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       CustomInput(
//                         "Phone Number",
//                         mobileController,
//                         TextInputType.phone,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Visibility(
//                         visible: isInvestor || isStudent,
//                         child: CustomInput(
//                           "Address",
//                           addressController,
//                           TextInputType.streetAddress,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       CustomDropDown(roles, "Select Role", selectedRole),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       // Student's Fieds
//                       Visibility(
//                         visible: isStudent,
//                         child: Column(
//                           children: [
//                             Animate(
//                                 effects: const [
//                                   FadeEffect(
//                                     duration: Duration(
//                                       milliseconds: 300,
//                                     ),
//                                     delay: Duration(milliseconds: 100),
//                                   ),
//                                   FlipEffect(),
//                                 ],
//                                 child: DropdownButtonFormField(
//                                   items: [
//                                     'MCA FY',
//                                     'MCA SY',
//                                     'MBA FY',
//                                     'MBA SY'
//                                   ].map<DropdownMenuItem<String>>(
//                                       (String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                   validator: (value) =>
//                                       value == null ? 'Select Class ' : null,
//                                   hint: const Text("Select Class "),
//                                   decoration: const InputDecoration(
//                                     border: OutlineInputBorder(),
//                                   ),
//                                   onChanged: (String? value) {
//                                     selectedClass = value!;
//                                   },
//                                 )),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             StudentsFields()
//                           ],
//                         ),
//                       ),
//                       // Investor's Fields
//                       Visibility(
//                         visible: isInvestor,
//                         child: InvestorsFields(),
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: const ButtonStyle(
//                               backgroundColor:
//                                   MaterialStatePropertyAll(Colors.deepPurple)),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               print("Name = ${nameController.text}");
//                               print("Email = ${emailController.text}");
//                               print("Mobile = ${mobileController.text}");
//                               print("Address = ${addressController.text}");
//                               print("Class = $selectedClass");
//                               print("Role = $selectedRole");
//                               print("Role = ${_selectedRole.text}");
//                               print("Company = ${companyController.text}");
//                               print(
//                                   "Experience = ${experienceController.text}");
//                               // void createUserCollection() async {
//                               CollectionReference users = FirebaseFirestore
//                                   .instance
//                                   .collection('users');

//                               users
//                                   .add({
//                                     'uid': "test",
//                                     'email': "test",
//                                   })
//                                   .then((value) => print("User Added"))
//                                   .catchError((error) =>
//                                       print("Failed to add user: $error"));
//                               // }
//                             } else {
//                               // showDialog(
//                               //   context: context,
//                               //   builder: (context) {
//                               //     return AlertDialog(
//                               //       title: Text("Error "),
//                               //     );
//                               //   },
//                               // );
//                             }
//                           },
//                           child: const Text(
//                             " Register",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget CustomDropDown(List list, String hinttext, String selectedRole) {
//     return Container(
//       padding: const EdgeInsets.all(0),
//       width: double.infinity,
//       child: DropdownButtonFormField(
//         items: ['Investor', 'Student', 'Mentor']
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//         hint: const Text("Select Role "),
//         decoration: const InputDecoration(border: OutlineInputBorder()),
//         validator: (value) => value == null ? 'Select Role' : null,
//         onChanged: (String? value) {
//           setState(() {
//             selectedRole = value!;
//             if (selectedRole == "Student") {
//               isStudent = !isStudent;
//             } else {
//               isStudent = false;
//             }
//             if (selectedRole == "Investor") {
//               isInvestor = !isInvestor;
//             } else {
//               isInvestor = false;
//             }
//             if (selectedRole == "Mentor") {
//               isMentor = !isMentor;
//             } else {
//               isMentor = false;
//             }
//           });
//         },
//       ),
//     );
//   }

//   Widget CustomInput(String labeltext, TextEditingController controller,
//       TextInputType textInputType) {
//     return TextFormField(
//         decoration: InputDecoration(
//           border: const OutlineInputBorder(),
//           labelText: labeltext,
//         ),
//         controller: controller,
//         keyboardType: textInputType,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter Full Name ';
//           }
//           return null;
//         });
//   }

//   Widget StudentsFields() {
//     return Column(
//       children: [
//         Animate(
//           effects: const [
//             FadeEffect(
//                 duration: Duration(milliseconds: 300),
//                 delay: Duration(milliseconds: 300)),
//             FlipEffect(),
//           ],
//         ),
//         Animate(
//           effects: const [
//             FadeEffect(
//                 duration: Duration(milliseconds: 300),
//                 delay: Duration(milliseconds: 500)),
//             FlipEffect(),
//           ],
//           child: CustomInput(
//             "Roll Number",
//             rollnoController,
//             TextInputType.number,
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }

//   Widget InvestorsFields() {
//     return Column(
//       children: [
//         Animate(
//           effects: const [
//             FadeEffect(
//               duration: Duration(
//                 milliseconds: 200,
//               ),
//               delay: Duration(milliseconds: 100),
//             ),
//             FlipEffect(),
//           ],
//           child: CustomInput(
//             "Occupation ",
//             companyController,
//             TextInputType.text,
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Animate(
//           effects: const [
//             FadeEffect(
//               duration: Duration(
//                 milliseconds: 200,
//               ),
//               delay: Duration(milliseconds: 300),
//             ),
//             FlipEffect(),
//           ],
//           child: CustomInput(
//             "Experience ",
//             experienceController,
//             TextInputType.number,
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_funding/bloc/registration_bloc/bloc/registration_bloc_bloc.dart';
import 'package:startup_funding/widgets/reg_widgets.dart';
import 'package:startup_funding/widgets/registration_form_widgets.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  RegistrationBloc _registrationBloc = RegistrationBloc();
  @override
  void initState() {
    // TODO: implement initState
    _registrationBloc.add(RegistrationInitialEvent());
    super.initState();
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String selectedRole = "";
  String selectedClass = "";
  bool isStudent = false;
  bool isInvestor = false;
  bool isMentor = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration "),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            RegistrationFormWidgets().CustomInput('Name', _nameController,
                TextInputType.name, "Enter Full Name "),
            RegistrationFormWidgets().CustomInput('Email', _emailController,
                TextInputType.emailAddress, "Enter Email Address"),
            RegistrationFormWidgets().CustomInput('Phone', _phoneController,
                TextInputType.phone, "Enter Phone Number"),
            Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
              child: DropdownButtonFormField(
                items: ['Investor', 'Mentor', 'Student']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) => value == null ? ' Select Role ' : null,
                hint: const Text("Select Role "),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  selectedRole = value!;
                  if (selectedRole == "Student") {
                    _registrationBloc.add(StudentRoleSelectedEvent());
                    debugPrint("Student");
                    isStudent = !isStudent;
                  } else {
                    isStudent = false;
                  }
                  if (selectedRole == "Investor") {
                    _registrationBloc.add(InvestorRoleSelectedEvent());
                    debugPrint("Investor");
                    isInvestor = !isInvestor;
                  } else {
                    isInvestor = false;
                  }
                  if (selectedRole == "Mentor") {
                    _registrationBloc.add(MentorRoleSelectedEvent());
                    debugPrint("Mentor");
                    isMentor = !isMentor;
                  } else {
                    isMentor = false;
                  }
                },
              ),
            ),
            RegistrationFormWidgets().CustomInput("Password",
                _passwordController, TextInputType.text, "Please  Password "),
            BlocConsumer<RegistrationBloc, RegistrationState>(
              bloc: _registrationBloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is RegistrationInitialState) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [],
                    ),
                  );
                }
                if (state is StudentRegistrationFormState) {
                  return Column(children: [
                    RegistrationFormWidgets().CustomInput(
                        'Address',
                        _addressController,
                        TextInputType.streetAddress,
                        "Enter Address "),
                    Container(
                      margin:
                          EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
                      padding:
                          EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
                      child: DropdownButtonFormField(
                        items: ['MCA FY', 'MCA SY', 'MBA FY', 'MBA SY']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) =>
                            value == null ? 'Select Class ' : null,
                        hint: const Text("Select Class "),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value) {
                          selectedClass = value!;
                        },
                      ),
                    ),
                  ]);
                }
                // if (state is MentorRegistrationFormState) {
                //   return Container(
                //     child: const Center(
                //       child: Text("Mentor Form "),
                //     ),
                //   );
                // }
                if (state is InvestorRegistrationFormState) {
                  return Column(
                    children: [
                      RegistrationFormWidgets().CustomInput(
                          'Occupation',
                          _occupationController,
                          TextInputType.text,
                          "Enter Occupation"),
                      RegistrationFormWidgets().CustomInput(
                          'Address',
                          _addressController,
                          TextInputType.streetAddress,
                          "Enter Address"),
                      RegistrationFormWidgets().CustomInput(
                          'Experience',
                          _experienceController,
                          TextInputType.number,
                          "Enter Experience "),
                    ],
                  );
                }
                if (state is RegistrationFailedState) {
                  return AlertDialog(
                    title: Text("Something went Wrong !!! "),
                  );
                }
                // if (state is RegistrationInProgressState) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     showDialog(
                //       context: context,
                //       builder: (context) => const AlertDialog(
                //         title: Text("Loading"),
                //       ),
                //     );
                //   });
                // }
                // if (state is RegistrationSuccessState) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     showDialog(
                //       context: context,
                //       builder: (context) => const AlertDialog(
                //         title: Text("Registration Completed"),
                //       ),
                //     );
                //   });
                // }
                return SizedBox();
              },
            ),
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepPurple)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Name = ${_nameController.text}");
                    print("Email = ${_emailController.text}");
                    print("Mobile = ${_phoneController.text}");
                    print("Role = $selectedRole");
                    print("Class = $selectedClass");
                    print("Experience = ${_experienceController.text}");
                    print("Occupation = ${_occupationController.text}");
                    _registrationBloc
                        .add(RegisterButtonClickedEventEvent(selectedRole, {
                      "name": _nameController.text,
                      "phone": _phoneController.text,
                      "email": _emailController.text,
                      "address": _emailController.text,
                      "role": selectedRole,
                      "class": selectedClass,
                      "password": _passwordController.text,
                      "occupation": _occupationController.text,
                      "experience": _experienceController.text,
                    }));
                    Future.delayed(
                        Duration(milliseconds: 800), () => dispose());
                    // print("Address = ${addressController.text}");
                    // print("Role = ${_selectedRole.text}");S
                    // print("Company = ${companyController.text}");
                    // void createUserCollection() async {
                    //   CollectionReference users =
                    //       FirebaseFirestore.instance.collection('users');

                    //   users
                    //       .add({
                    //         'uid': "test",
                    //         'email': "test",
                    //       })
                    //       .then((value) => print("User Added"))
                    //       .catchError((error) => print("Failed to add user: $error"));
                  }
                },
                child: const Text(
                  " Register",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _addressController.clear();
    _emailController.clear();
    _experienceController.clear();
    _nameController.clear();
    _occupationController.clear();
    _phoneController.clear();
    _passwordController.clear();

    // super.dispose();
  }
}
