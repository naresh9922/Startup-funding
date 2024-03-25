import 'package:flutter/material.dart';

class RegistrationFormWidgets {
  Widget CustomInput(String labeltext, TextEditingController controller,
      TextInputType textInputType, String validatorText) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
      child: TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labeltext,
          ),
          controller: controller,
          keyboardType: textInputType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            }
            return null;
          }),
    );
  }

  Widget CustomDropDown(
      List list, String hinttext, String selectedValue, VoidCallback onChange) {
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
          // setState(() {
          //   selectedValue = value!;
          //   if (selectedValue == "Student") {
          //     isStudent = !isStudent;
          //   } else {
          //     isStudent = false;
          //   }
          //   if (selectedValue == "Investor") {
          //     isInvestor = !isInvestor;
          //   } else {
          //     isInvestor = false;
          //   }
          //   if (selectedValue == "Mentor") {
          //     isMentor = !isMentor;
          //   } else {
          //     isMentor = false;
          //   }
          // });
        },
      ),
    );
  }
}
