import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

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
        appBar: AppBar(
          title: const Text('Assurly registration'),
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: firstNameController,
                            decoration: const InputDecoration(
                              label: Text('Firstname'),
                            ),
                            onChanged: (value) {
                              setState(() => firstName = value);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your firstname';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                setState(() => firstName = value!),
                          ),
                          TextFormField(
                            controller: lastNameController,
                            decoration: const InputDecoration(
                              label: Text("Lastname"),
                            ),
                            onChanged: (value) {
                              setState(() => lastName = value);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                setState(() => lastName = value!),
                          ),
                          _FormDatePicker(
                            birthDate: birthDate,
                            onChanged: (value) {
                              setState(() => birthDate = value);
                            },
                            onSaved: (value) =>
                                setState(() => birthDate = value!),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                form?.save();
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ))),
        ));
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime birthDate;
  final ValueChanged<DateTime> onChanged;
  final onSaved;

  const _FormDatePicker({
    required this.birthDate,
    required this.onChanged,
    this.onSaved,
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
              'Date',
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

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title:Text("DatePicker on TextField"), 
//             backgroundColor: Colors.redAccent, //background color of app bar
//         ),
//         body:Container(
//           padding: EdgeInsets.all(15),
//           height:150,
//           child:Center( 
//              child:TextField(
//                 controller: dateinput, //editing controller of this TextField
//                 decoration: InputDecoration( 
//                    icon: Icon(Icons.calendar_today), //icon of text field
//                    labelText: "Enter Date" //label text of field
//                 ),
//                 readOnly: true,  //set it true, so that user will not able to edit text
//                 onTap: () async {
//                   DateTime pickedDate = await showDatePicker(
//                       context: context, initialDate: DateTime.now(),
//                       firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
//                       lastDate: DateTime(2101)
//                   );
                  
//                   if(pickedDate != null ){
//                       print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
//                       String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
//                       print(formattedDate); //formatted date output using intl package =>  2021-03-16
//                         //you can implement different kind of Date Format here according to your requirement

//                       setState(() {
//                          dateinput.text = formattedDate; //set output date to TextField value. 
//                       });
//                   }else{
//                       print("Date is not selected");
//                   }
//                 },
//              )
//           )
//         )
//     );
//   }
// }
