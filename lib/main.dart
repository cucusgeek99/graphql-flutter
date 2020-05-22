import 'package:flutter/material.dart';
import 'package:graphql_test/country_list.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  	/// HttpLink - A system of modular components for GraphQL networking.
    final HttpLink httpLink =
        HttpLink(uri: 'https://marql.herokuapp.com/v1/graphql');
  
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GraphQLProvider(
        child: CountryListView(),
        client: client,
      ),
    );
  }
}