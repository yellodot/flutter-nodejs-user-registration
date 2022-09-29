import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:usecase_assurly/api_service.dart';
import 'package:usecase_assurly/models/register_user_model.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  DateTime birthDate = DateTime.now();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birtDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 188, 30),
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Center(
                      child: Text(
                        "Create account",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 122, 122, 122),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: firstNameController,
                        decoration: InputDecoration(
                          hintText: "Firstname",
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() => firstName = value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your firstname';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: lastNameController,
                        decoration: InputDecoration(
                          hintText: "Lastname",
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() => lastName = value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your lastname';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    TextField(
                        controller: birtDateController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Birthdate"),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('dd-MM-yyyy').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            setState(() {
                              birtDateController.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          'User $firstName $lastName created successfully !'),
                                    );
                                  },
                                );
                                setState(() {
                                  final user = RegisterUserModel(
                                      firstNameController,
                                      lastNameController,
                                      birtDateController,
                                      firstname: firstName,
                                      lastname: lastName,
                                      birthdate: birthDate.toString());

                                  ApiService().createUser(user);
                                });
                              }
                              firstNameController.clear();
                              lastNameController.clear();
                              birtDateController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 236, 188, 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15)),
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
