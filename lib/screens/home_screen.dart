import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/covid_provider.dart';
import '../models/covid_data.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('COVID-19 Tracker')),
      body: Consumer<CovidProvider>(
        builder: (context, provider, child) {
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }
          return Column(
            children: [
              ElevatedButton(
                onPressed: () => provider.fetchGlobalData(),
                child: Text('Fetch Global Data'),
              ),
              provider.globalData != null
                  ? ListTile(
                      title: Text('Global Cases: ${provider.globalData!.cases}'),
                      subtitle: Text('Global Deaths: ${provider.globalData!.deaths}'),
                    )
                  : Container(),
              TextField(
                controller: countryController,
                decoration: InputDecoration(labelText: 'Enter Country'),
              ),
              ElevatedButton(
                onPressed: () => provider.fetchCountryData(countryController.text),
                child: Text('Fetch Country Data'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.countryDataList.length,
                  itemBuilder: (context, index) {
                    final data = provider.countryDataList[index];
                    return ListTile(
                      title: Text(data.country),
                      subtitle: Text('Cases: ${data.cases}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(data: data),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => provider.deleteCountryData(data.country),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
