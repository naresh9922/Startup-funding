import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_funding/pages/home.dart';
import 'package:startup_funding/widgets/registration_form_widgets.dart';

import '../bloc/registration_bloc/registration_bloc_bloc.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final RegistrationBloc _registrationBloc = RegistrationBloc();
  @override
  void initState() {
    _registrationBloc.add(RegistrationInitialEvent());
    super.initState();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
            RegistrationFormWidgets().Customemail('Email', _emailController,
                TextInputType.emailAddress, "Enter Email Address"),
            RegistrationFormWidgets().Customphone('Phone', _phoneController,
                TextInputType.phone, "Enter Phone Number"),
            Container(
              margin:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
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
              listener: (context, state) {
                if (state is RegistrationSuccessState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  });
                }
              },
              builder: (context, state) {
                if (state is RegistrationInitialState) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    child: const Column(
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
                      margin: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 4, top: 5),
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 4, top: 5),
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
                  return const AlertDialog(
                    title: Text("Something went Wrong !!! "),
                  );
                }

                return const SizedBox();
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
                    debugPrint("Name = ${_nameController.text}");
                    debugPrint("Email = ${_emailController.text}");
                    debugPrint("Mobile = ${_phoneController.text}");
                    debugPrint("Role = $selectedRole");
                    debugPrint("Class = $selectedClass");
                    debugPrint("Experience = ${_experienceController.text}");
                    debugPrint("Occupation = ${_occupationController.text}");
                    _registrationBloc
                        .add(RegisterButtonClickedEventEvent(selectedRole, {
                      "role": selectedRole,
                      "name": _nameController.text,
                      "phone": _phoneController.text,
                      "email": _emailController.text,
                      "address": _addressController.text,
                      "class": selectedClass,
                      "password": _passwordController.text,
                      "occupation": _occupationController.text,
                      "experience": _experienceController.text,
                    }));
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
    _addressController.clear();
    _emailController.clear();
    _experienceController.clear();
    _nameController.clear();
    _occupationController.clear();
    _phoneController.clear();
    _passwordController.clear();
    super.dispose();
  }
}
