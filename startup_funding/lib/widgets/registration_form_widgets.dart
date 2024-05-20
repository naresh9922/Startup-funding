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
          enableSuggestions: true,
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

  Widget Customphone(String labeltext, TextEditingController controller,
      TextInputType textInputType, String validatorText) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
      child: TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labeltext,
          ),
          enableSuggestions: true,
          controller: controller,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return 'Please enter a valid 10-digit phone number';
            }
            return null;
          }),
    );
  }

  Widget Customemail(String labeltext, TextEditingController controller,
      TextInputType textInputType, String validatorText) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 5),
      child: TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labeltext,
          ),
          enableSuggestions: true,
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                .hasMatch(value)) {
              return 'Please enter a valid email address';
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
        onChanged: (String? value) {},
      ),
    );
  }
}
