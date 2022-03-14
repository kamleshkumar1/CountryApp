import 'dart:convert';

import 'package:ezcountries/repo/model/country_model.dart';
import 'package:ezcountries/helper/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DataProvider {
  late GraphQLClient client;

  DataProvider() {
    client = GraphQLClient(link: HttpLink(
      'https://countries.trevorblades.com/graphql',
    ), cache: GraphQLCache());
  }
  //---- fetch api for fetching the country-----------//
  Future fetchCountry() async {
    final String query = Queries.country();
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );

    return result.data;
  }
  Future getCountryByCode(context, {String? code}) async {
    final String query = Queries.searchByCode(lgCode: code);
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    if (result.hasException) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Country Code Not Found"),
        backgroundColor: Colors.red,
      ));
      return null;
    }
    return result.data;
  }

  Future getLanguages() async {
    final String query = Queries.language();
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    return result.data!['languages'];
  }


}
