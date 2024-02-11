import 'package:flutter/material.dart';
import 'package:finwise/screens/choice_screen.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});
  @override
  State<UserInfoPage> createState() {
    return _UserInfoPageState();
    }
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController incomeController = TextEditingController();
  TextEditingController landAreaController = TextEditingController();
  TextEditingController farmingController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController vehiclesController = TextEditingController();

  List<Dependant> dependants = [];

  void addDependant() {
    setState(() {
      dependants.add(Dependant());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter income',
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Assets',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: landAreaController,
              decoration: const InputDecoration(
                hintText: 'Land Area',
              ),
            ),
            TextFormField(
              controller: farmingController,
              decoration: const InputDecoration(
                hintText: 'Farming',
              ),
            ),
            TextFormField(
              controller: houseController,
              decoration: const InputDecoration(
                hintText: 'House',
              ),
            ),
            TextFormField(
              controller: vehiclesController,
              decoration: const InputDecoration(
                hintText: 'Vehicles',
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Dependants Details',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: dependants.length,
              itemBuilder: (context, index) {
                return DependantForm(
                  dependant: dependants[index],
                );
              },
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: addDependant,
              child:const Text('Add Dependant'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChoiceScreen(),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class Dependant {
  String name = '';
  String gender = '';
  int age = 0;
  String maritalStatus = '';
}

class DependantForm extends StatelessWidget {
  final Dependant dependant;

  const DependantForm({required this.dependant, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: (value) => dependant.name = value,
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
        ),
        TextFormField(
          onChanged: (value) => dependant.gender = value,
          decoration: const InputDecoration(
            labelText: 'Gender',
          ),
        ),
        TextFormField(
          onChanged: (value) => dependant.age = int.tryParse(value) ?? 0,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Age',
          ),
        ),
        TextFormField(
          onChanged: (value) => dependant.maritalStatus = value,
          decoration: const InputDecoration(
            labelText: 'Marital Status',
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
