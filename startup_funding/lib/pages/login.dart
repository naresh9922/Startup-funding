import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_funding/pages/home.dart';
import 'package:startup_funding/pages/registration.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String selectedRole = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text("Login"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 110.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Text(
                    "StartUp Funding",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Email Id ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter Password'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 4, top: 5),
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 4, top: 5),
                    child: DropdownButtonFormField(
                      items: ['Student', 'Investor', 'Mentor']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? 'Select Role ' : null,
                      hint: const Text("Select Role "),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    width: 360,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          child: const Text(
                            'Log in ',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: InkWell(
                        onTap: () {
                          print('hello');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registration(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        )),
                  ),
                ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 62),
                      child: Text('Forgot your login details? '),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: InkWell(
                        onTap: () {
                          print('hello');
                        },
                        child: const Text(
                          'Get help logging in.',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _emailController.text)
        .where('password', isEqualTo: _passwordController.text)
        .where('role', isEqualTo: selectedRole)
        .get();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (snapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        print(" Snapshot ${data}");
        print(" ID ${document.id}");
        if (data['role'] == "Student") {
          await _prefs.setStringList("userDetails", [
            data['name'],
            data['phone'],
            data['email'],
            data['class'],
            data['address'],
            data['uuid'],
          ]);
        }
        if (data['role'] == "Mentor") {
          await _prefs.setStringList("userDetails", [
            data['name'],
            data['phone'],
            data['email'],
            data['uuid'],
          ]);
        }
        if (data['role'] == "Investor") {
          await _prefs.setStringList("userDetails", [
            data['name'],
            data['phone'],
            data['email'],
            data['address'],
            data['occupation'],
            data['experience'],
            data['uuid'],
          ]);
        }
        _prefs.setBool('loggedIn', true);
      }
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      debugPrint("No User Found ");
    }
  }
}
