import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

const List<String> roles = <String>['Investor', 'Student'];

class _RegistrationState extends State<Registration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController rollnoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedClass = "";
  String selectedRole = "";
  final TextEditingController _selectedRole = TextEditingController();
  String dropdownValue = roles.first;
  bool isStudent = false;
  bool isInvestor = false;
  bool isMentor = false; // Remove this line
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomInput(
                        "Full Name",
                        nameController,
                        TextInputType.name,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInput(
                        "Email Id",
                        emailController,
                        TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInput(
                        "Phone Number",
                        mobileController,
                        TextInputType.phone,
                      ),
                      Visibility(
                        visible: isInvestor || isStudent,
                        child: CustomInput(
                          "Address",
                          addressController,
                          TextInputType.streetAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomDropDown(roles, "Select Role", selectedRole),
                      const SizedBox(
                        height: 20,
                      ),
                      // Student's Fieds
                      Visibility(
                        visible: isStudent,
                        child: Column(
                          children: [
                            Animate(
                                effects: const [
                                  FadeEffect(
                                    duration: Duration(
                                      milliseconds: 300,
                                    ),
                                    delay: Duration(milliseconds: 100),
                                  ),
                                  FlipEffect(),
                                ],
                                child: DropdownButtonFormField(
                                  items: [
                                    'MCA FY',
                                    'MCA SY',
                                    'MBA FY',
                                    'MBA SY'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            StudentsFields()
                          ],
                        ),
                      ),
                      // Investor's Fields
                      Visibility(
                        visible: isInvestor,
                        child: InvestorsFields(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.deepPurple)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("Name = ${nameController.text}");
                              print("Email = ${emailController.text}");
                              print("Mobile = ${mobileController.text}");
                              print("Address = ${addressController.text}");
                              print("Class = $selectedClass");
                              print("Role = $selectedRole");
                              print("Role = ${_selectedRole.text}");
                              print("Company = ${companyController.text}");
                              print(
                                  "Experience = ${experienceController.text}");
                            } else {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return AlertDialog(
                              //       title: Text("Error "),
                              //     );
                              //   },
                              // );
                            }
                          },
                          child: const Text(
                            " Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomDropDown(List list, String hinttext, String selectedValue) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: double.infinity,
      child: DropdownButtonFormField(
        items: ['Investor', 'Student', 'Mentor']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: const Text("Select Role "),
        decoration: const InputDecoration(border: OutlineInputBorder()),
        validator: (value) => value == null ? 'Select Role' : null,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value!;
            if (selectedValue == "Student") {
              isStudent = !isStudent;
            } else {
              isStudent = false;
            }
            if (selectedValue == "Investor") {
              isInvestor = !isInvestor;
            } else {
              isInvestor = false;
            }
            if (selectedValue == "Mentor") {
              isMentor = !isMentor;
            } else {
              isMentor = false;
            }
          });
        },
      ),
    );
  }

  Widget CustomInput(String labeltext, TextEditingController controller,
      TextInputType textInputType) {
    return TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labeltext,
        ),
        controller: controller,
        keyboardType: textInputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Full Name ';
          }
          return null;
        });
  }

  Widget StudentsFields() {
    return Column(
      children: [
        Animate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 300),
                delay: Duration(milliseconds: 300)),
            FlipEffect(),
          ],
        ),
        Animate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 300),
                delay: Duration(milliseconds: 500)),
            FlipEffect(),
          ],
          child: CustomInput(
            "Roll Number",
            rollnoController,
            TextInputType.number,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget InvestorsFields() {
    return Column(
      children: [
        Animate(
          effects: const [
            FadeEffect(
              duration: Duration(
                milliseconds: 200,
              ),
              delay: Duration(milliseconds: 100),
            ),
            FlipEffect(),
          ],
          child: CustomInput(
            "Occupation ",
            companyController,
            TextInputType.text,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Animate(
          effects: const [
            FadeEffect(
              duration: Duration(
                milliseconds: 200,
              ),
              delay: Duration(milliseconds: 300),
            ),
            FlipEffect(),
          ],
          child: CustomInput(
            "Experience ",
            experienceController,
            TextInputType.number,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
