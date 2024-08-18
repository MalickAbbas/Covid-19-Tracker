import 'package:flutter/material.dart';
import '../models/covid_data.dart';
import '../services/api_service.dart';

class CovidProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  CovidData? globalData;
  List<CovidData> countryDataList = [];
  String? errorMessage;

  Future<void> fetchGlobalData() async {
    try {
      globalData = await apiService.fetchGlobalData();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchCountryData(String country) async {
    try {
      CovidData data = await apiService.fetchCountryData(country);
      countryDataList.add(data);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> createCountryData(CovidData data) async {
    await apiService.createCountryData(data);
    countryDataList.add(data);
    notifyListeners();
  }

  Future<void> updateCountryData(String country, CovidData data) async {
    await apiService.updateCountryData(country, data);
    int index = countryDataList.indexWhere((element) => element.country == country);
    if (index != -1) {
      countryDataList[index] = data;
      notifyListeners();
    }
  }

  Future<void> deleteCountryData(String country) async {
    await apiService.deleteCountryData(country);
    countryDataList.removeWhere((element) => element.country == country);
    notifyListeners();
  }
}
