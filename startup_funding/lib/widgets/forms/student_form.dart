import 'package:flutter/material.dart';
import 'package:startup_funding/widgets/registration_form_widgets.dart';

class StudentFormFields extends StatefulWidget {
  const StudentFormFields({super.key});

  @override
  State<StudentFormFields> createState() => _StudentFormFieldsState();
}

class _StudentFormFieldsState extends State<StudentFormFields> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        // RegistrationFormWidgets().CustomInput('Name', controller, textInputType)
      ],
    ));
  }
}
