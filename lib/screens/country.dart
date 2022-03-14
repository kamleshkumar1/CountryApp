import 'package:ezcountries/repo/provider/country_provider.dart';
import 'package:ezcountries/screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repo/model/country_model.dart';

class CountryList extends StatefulWidget {
  CountryList({Key? key}) : super(key: key);

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late CountryProvider provider;

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await provider.getCountry();
      await provider.getLanguages();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country"),
        actions: [
          ModalBottomSheetDemo(),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              Route route = MaterialPageRoute(builder: (_) => SearchByCodeCountry());
              Navigator.push(context, route);
            },
          ),
          if (provider.filterCountries.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              color: Colors.white,
              onPressed: () {
                provider.filterCountries.clear();
                provider.notifylistener();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: provider.countries!.isEmpty
                ? Center(child: CupertinoActivityIndicator())
                : _countryList(),
          ),
        ],
      ),
    );
  }

  Widget _countryList() {
    List<CountryModel> _countryList = provider.filterCountries.isNotEmpty
        ? provider.filterCountries
        : provider.countries!;
    return ListView.separated(
        itemCount: _countryList.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(_countryList[index].emoji ?? ""),
            title: Text(_countryList[index].name!),
            subtitle: Text(_countryList[index].capital ?? ""),
          );
        });
  }
}

class ModalBottomSheetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_alt),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (BuildContext context) {
            return SizedBox(
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                      Provider.of<CountryProvider>(context).languages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        await Provider.of<CountryProvider>(context,
                                listen: false)
                            .filter(Provider.of<CountryProvider>(context,
                                    listen: false)
                                .languages[index]
                                .name!);
                        Provider.of<CountryProvider>(context, listen: false)
                            .notifylistener();
                        Navigator.of(context).pop();
                      },
                      title: Text(Provider.of<CountryProvider>(context)
                          .languages[index]
                          .name!),
                    );
                  }),
            );
          },
        );
      },
    );
  }
}
