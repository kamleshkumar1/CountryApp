import 'dart:convert';
import 'dart:developer';

import 'package:ezcountries/repo/model/country_model.dart';
import 'package:ezcountries/data_source/country_data_source.dart';
import 'package:flutter/material.dart';

import '../model/language_model.dart';

class CountryProvider extends ChangeNotifier {
  DataProvider data_provider = DataProvider();
  List<CountryModel>? _countries = [];
  List<Language> _languages = [];
  CountryModel? _country;
  List<CountryModel> filterCountries = [];
  List<CountryModel>? get countries => _countries;

  List<Language> get languages => _languages;

  CountryModel? get country => _country;

  Future notifylistener() async {
    notifyListeners();
  }
  Future<void> getCountry() async {
    final result = await data_provider.fetchCountry();
    _countries = result["countries"].map<CountryModel>((x) => CountryModel.fromJson(x)).toList();
    _countries!.sort((a, b) => a.name!.compareTo(b.name!));
    notifyListeners();
  }

  Future<void> getLanguages() async {
    final result = await data_provider.getLanguages();
    for (var l in result) {
      _languages.add(Language.fromJson(l));
    }
    _languages = languages.reversed.toList();
    notifyListeners();
  }

  Future getCountryNameByCode(context, {String? code}) async {
    final result = await data_provider.getCountryByCode(context, code: code);
    if (result != null) {
      if (result['country'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Country not Found exists",
          style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
        return;
      }
      final country_Md = CountryModel.fromJson(result['country']);
      _country = country_Md;
      filterCountries.add(country_Md);
      notifyListeners();
      return country_Md.name;
    }
  }


  Future<void> filter(String languageName) async {
    filterCountries.clear();
    for (var i in _countries!){
      for(var lan in i.languages!){
        if(lan.name!.toLowerCase().contains(languageName.toLowerCase())){
          filterCountries.add(i);
        }
      }
    }
    notifylistener();
  }

}
