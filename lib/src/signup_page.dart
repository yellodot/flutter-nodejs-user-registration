import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
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
                    _FormDatePicker(
                        birthDate: birthDate,
                        onChanged: (value) {
                          setState(() => birthDate = value);
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
                                          'User ${firstNameController.text} ${lastNameController.text} created successfully !'),
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
                                backgroundColor: Color.fromARGB(255, 236, 188, 30),
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
    // return Scaffold(
    //     backgroundColor: Colors.grey[200],
    //     body: Center(
    //       child: Form(
    //           key: _formKey,
    //           child: Align(
    //             alignment: Alignment.topCenter,
    //             child: ConstrainedBox(
    //               constraints: const BoxConstraints(maxWidth: 400),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   TextFormField(
    //                       controller: firstNameController,
    //                       decoration: const InputDecoration(
    //                         label: Text('Firstname'),
    //                       ),
    //                       onChanged: (value) {
    //                         setState(() => firstName = value);
    //                       },
    //                       validator: (value) {
    //                         if (value!.isEmpty) {
    //                           return 'Please enter your firstname';
    //                         }
    //                         return null;
    //                       }),
    //                   TextFormField(
    //                       controller: lastNameController,
    //                       decoration: const InputDecoration(
    //                         label: Text("Lastname"),
    //                       ),
    //                       onChanged: (value) {
    //                         setState(() => lastName = value);
    //                       },
    //                       validator: (value) {
    //                         if (value!.isEmpty) {
    //                           return 'Please enter your last name';
    //                         }
    //                         return null;
    //                       }),
    //                   _FormDatePicker(
    //                       birthDate: birthDate,
    //                       onChanged: (value) {
    //                         setState(() => birthDate = value);
    //                       }),
    //                   ElevatedButton(
    //                     onPressed: () {
    //                       if (_formKey.currentState!.validate()) {
    //                         showDialog(
    //                           context: context,
    //                           builder: (context) {
    //                             return AlertDialog(
    //                               content: Text(
    //                                   'User ${firstNameController.text} ${lastNameController.text} created successfully !'),
    //                             );
    //                           },
    //                         );
    //                         setState(() {
    //                           final user = RegisterUserModel(
    //                               firstNameController,
    //                               lastNameController,
    //                               birtDateController,
    //                               firstname: firstName,
    //                               lastname: lastName,
    //                               birthdate: birthDate.toString());

    //                           ApiService().createUser(user);
    //                         });
    //                       }
    //                       firstNameController.clear();
    //                       lastNameController.clear();
    //                       birtDateController.clear();
    //                     },
    //                     child: const Text('Submit'),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           )),
    //     ));
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime birthDate;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.birthDate,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Birthdate',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.birthDate),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        TextButton(
          child: const Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.birthDate,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (newDate == null) {
              return;
            }
            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
