import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/covid_data.dart';
import '../providers/covid_provider.dart';

class DetailsScreen extends StatelessWidget {
  final CovidData data;
  final TextEditingController casesController = TextEditingController();
  final TextEditingController deathsController = TextEditingController();
  final TextEditingController recoveredController = TextEditingController();

  DetailsScreen({super.key, required this.data}) {
    casesController.text = data.cases.toString();
    deathsController.text = data.deaths.toString();
    recoveredController.text = data.recovered.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${data.country} Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: casesController,
              decoration: const InputDecoration(labelText: 'Cases'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: deathsController,
              decoration: const InputDecoration(labelText: 'Deaths'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: recoveredController,
              decoration: const InputDecoration(labelText: 'Recovered'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                final updatedData = CovidData(
                  country: data.country,
                  cases: int.parse(casesController.text),
                  deaths: int.parse(deathsController.text),
                  recovered: int.parse(recoveredController.text),
                );
                Provider.of<CovidProvider>(context, listen: false)
                    .updateCountryData(data.country, updatedData);
                Navigator.pop(context);
              },
              child: const Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
