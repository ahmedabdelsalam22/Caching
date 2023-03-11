import 'package:flutter/material.dart';

import '../data/Employee.dart';
import 'controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Caching"),
      ),
      body: FutureBuilder(
        future: EmployeesController.getAllEmployees(),
        builder: (context, AsyncSnapshot<List<Data>?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].employeeName!),
                    subtitle:
                        Text(snapshot.data![index].employeeSalary.toString()),
                    trailing:
                        Text(snapshot.data![index].employeeAge.toString()),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(child: Text("No data Found"));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
