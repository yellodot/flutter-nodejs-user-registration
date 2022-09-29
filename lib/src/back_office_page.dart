import 'package:flutter/material.dart';
import 'package:usecase_assurly/models/user_model.dart';
import 'package:usecase_assurly/api_service.dart';

// class UserTable extends StatelessWidget {
//   const UserTable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Back-office'),
//       ),
//       body: Center(
//           child: DataTable(
//         columns: const <DataColumn>[
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Firstname',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//           ),
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Lastname',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//           ),
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Birthdate',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//           ),
//           DataColumn(
//             label: Expanded(
//               child: Text(
//                 'Creation date',
//                 style: TextStyle(fontStyle: FontStyle.italic),
//               ),
//             ),
//           ),
//         ],
//         rows: const <DataRow>[
//           DataRow(
//             cells: <DataCell>[
//               DataCell(Text('Sarah')),
//               DataCell(Text('Jackson')),
//               DataCell(Text('14/05/1978')),
//               DataCell(Text('29032022')),
//             ],
//           ),
//           DataRow(
//             cells: <DataCell>[
//               DataCell(Text('Janine')),
//               DataCell(Text('Dupont')),
//               DataCell(Text('14/05/1978')),
//               DataCell(Text('29032022')),
//             ],
//           ),
//           DataRow(
//             cells: <DataCell>[
//               DataCell(Text('William')),
//               DataCell(Text('Martin')),
//               DataCell(Text('14/05/1978')),
//               DataCell(Text('29032022')),
//             ],
//           ),
//         ],
//       )),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _userModel!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_userModel![index].id.toString()),
                          Text(_userModel![index].firstname),
                          Text(_userModel![index].birthdate.toString()),
                          Text(_userModel![index].createdAt.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
