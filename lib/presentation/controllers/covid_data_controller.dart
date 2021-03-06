import 'package:covid19_tracker_in_flutter/domain/contracts/covid_contract.dart';
import 'package:covid19_tracker_in_flutter/domain/entities/continent_summary.dart';
import 'package:covid19_tracker_in_flutter/domain/entities/country.dart';
import 'package:covid19_tracker_in_flutter/domain/entities/country_summary.dart';
import 'package:covid19_tracker_in_flutter/domain/entities/historical.dart';
import 'package:covid19_tracker_in_flutter/domain/entities/summary.dart';
import 'package:covid19_tracker_in_flutter/domain/use_cases/country_use_case.dart';
import 'package:covid19_tracker_in_flutter/domain/use_cases/covid_use_case.dart';
import 'package:covid19_tracker_in_flutter/presentation/widgets/my_snackbar.dart';
import 'package:get/get.dart';

class CovidDataController extends GetxController {
  CovidDataController(CountryUseCase countryUC, CovidUseCase covidUC) {
    _dbUseCase = countryUC;
    _apiUseCase = covidUC;
    _loadData();
  }

  CountryUseCase _dbUseCase;
  CovidUseCase _apiUseCase;
  Rx<Summary> _worldSummary = Rx<Summary>();
  RxList<ContinentSummary> _continentSummarys = RxList<ContinentSummary>();
  RxList<String> _allCountriesNames = RxList<String>();
  RxList<Country> _favoriteCountries = RxList<Country>();
  Map _countrySummarys = Map<String, CountrySummary>();
  Map _countryHistoricals = Map<String, Historical>();

  Summary get worldSummary => _worldSummary?.value;
  List<ContinentSummary> get continentSummarys => _continentSummarys?.toList();
  List<String> get getAllCountriesNames => _allCountriesNames?.toList();
  List<Country> get favoriteCountries => _favoriteCountries.toList();

  void _loadData() {
    loadWorldSummary();
    loadContinentsSummary();
    loadFavoriteCountries();
  }

  Future<void> loadWorldSummary() async {
    try {
      Summary summary = await _apiUseCase.worldSummary();
      _worldSummary.value = summary;
    } catch (erro) {
      MySnackBar(message: erro.toString(), timeDelay: 1);
    }
  }

  Future<void> loadContinentsSummary() async {
    try {
      List<ContinentSummary> summarys = await _apiUseCase.continentsSummary();
      _continentSummarys.value = summarys;
      _saveAllCountries();
    } catch (erro) {
      MySnackBar(message: erro.toString(), timeDelay: 1);
    }
  }

  void _saveAllCountries() {
    _allCountriesNames.clear();
    for (final summary in continentSummarys)
      for (final name in summary.countries) _allCountriesNames.add(name);
    _allCountriesNames.sort((a, b) => a.compareTo(b));
  }

  Future<void> loadFavoriteCountries() async {
    try {
      final List<Country> favorites = List.from(await _dbUseCase.readAll());
      _favoriteCountries.value = favorites;
    } catch (erro) {
      MySnackBar(message: erro.toString(), timeDelay: 1);
    }
  }

  Future<void> addFavorite(String name) async {
    String id = await _dbUseCase.insert(name);
    _favoriteCountries.add(Country(id, name));
  }

  Future<void> removeFavorite(String id) async {
    await _dbUseCase.delete(id);
    _favoriteCountries.removeWhere((fav) => fav.id == id);
  }

  Future<CountrySummary> getCountryData(String countryName) async {
    if (_countrySummarys[countryName] == null) {
      _countrySummarys[countryName] = await _apiUseCase.findCountrySummary(
        countryName,
        Period.today,
      );
    }
    return _countrySummarys[countryName];
  }

  void redefineCountryData(String countryName) {
    _countrySummarys[countryName] = null;
  }

  Future<Historical> getCountryHistorical(String countryName) async {
    if (_countryHistoricals[countryName] == null) {
      _countryHistoricals[countryName] = await _apiUseCase.countryHistorical(
        countryName,
        'all',
      );
    }
    return _countryHistoricals[countryName];
  }
}
