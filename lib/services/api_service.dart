import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/covid_data.dart';

class ApiService {
  final String baseUrl = "https://disease.sh/v3/covid-19";

  Future<CovidData> fetchGlobalData() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      return CovidData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load global data');
    }
  }

  Future<CovidData> fetchCountryData(String country) async {
    final response = await http.get(Uri.parse('$baseUrl/countries/$country'));
    if (response.statusCode == 200) {
      return CovidData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load country data');
    }
  }

  Future<void> createCountryData(CovidData data) async {
    // Simulate a POST request (since the real API doesn't support it)
    // ignore: avoid_print
    print("Data for ${data.country} created");
  }

  Future<void> updateCountryData(String country, CovidData data) async {
    // Simulate a PUT request
    // ignore: avoid_print
    print("Data for $country updated to ${data.toJson()}");
  }

  Future<void> deleteCountryData(String country) async {
    // Simulate a DELETE request
    // ignore: avoid_print
    print("Data for $country deleted");
  }
}
