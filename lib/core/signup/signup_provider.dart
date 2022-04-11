import 'package:packs/models/country_list.dart';
import 'package:packs/models/country_model.dart';

const String PropertyName = 'alpha_2_code';

class SignupProvider {
  List<Country> getCountriesData() {
    final List<Map<String, dynamic>> jsonList = Countries.countryList;

    // if (countries == null || countries.isEmpty) {
    return jsonList.map((Map<String, dynamic> country) => Country.fromJson(country)).toList();
    // }
    // List filteredList = jsonList.where((country) {
    //   return countries.contains(country[PropertyName]);
    // }).toList();

    // return filteredList.map((country) => Country.fromJson(country)).toList();
  }
}
