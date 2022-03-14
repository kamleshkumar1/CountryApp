import 'package:ezcountries/repo/provider/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchByCodeCountry extends StatefulWidget {
  const SearchByCodeCountry({Key? key}) : super(key: key);

  @override
  _SearchByCodeCountryState createState() => _SearchByCodeCountryState();
}

class _SearchByCodeCountryState extends State<SearchByCodeCountry> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CountryProvider provider = Provider.of<CountryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                hintText: 'Code',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () async {
                await (provider.getCountryNameByCode(context,
                    code: _controller.text.trim().toUpperCase()));
                _controller.clear();
                Navigator.pop(context);
              },
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
