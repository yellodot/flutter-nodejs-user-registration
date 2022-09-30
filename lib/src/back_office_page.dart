import 'package:flutter/material.dart';
import 'package:usecase_assurly/models/user_model.dart';
import 'package:usecase_assurly/api_service.dart';

class UsersTable extends StatefulWidget {
  const UsersTable({Key? key}) : super(key: key);

  @override
  UsersTableState createState() => UsersTableState();
}

class UsersTableState extends State<UsersTable> {
  late List<UserModel>? _userModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Back-office'),
        ),
        body: _userModel == null || _userModel!.isEmpty
            ? const Center(
                child: Text("No users found"),
              )
            : Center(
                child: SingleChildScrollView(
                    child: (DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Firstname',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Lastname',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Birthdate',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Creation date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: List.generate(
                    _userModel!.length,
                    (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(_userModel![index].firstname)),
                            DataCell(Text(_userModel![index].lastname)),
                            DataCell(
                                Text(_userModel![index].birthdate.toString().substring(0, 10))),
                            DataCell(
                                Text(_userModel![index].createdAt.toString())),
                          ],
                        )),
              )
            )
          )
        )
      );
  }
}