class CovidData {
  final String country;
  final int cases;
  final int deaths;
  final int recovered;

  CovidData({required this.country, required this.cases, required this.deaths, required this.recovered});

  factory CovidData.fromJson(Map<String, dynamic> json) {
    return CovidData(
      country: json['country'],
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'cases': cases,
      'deaths': deaths,
      'recovered': recovered,
    };
  }
}
