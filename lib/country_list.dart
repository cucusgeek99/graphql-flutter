import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryListView extends StatelessWidget {
  final String query = '''
                            query{
  article {
    id
    title  
    author{
      id
      name
    }
  }
 
}
                  ''';
                  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des articles '),
      ),
      body: Query(
        options: QueryOptions(documentNode:
        gql(query) ),
         builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
            if (result.hasException) {
        return Text(result.exception.toString());
    }
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            return Center(child: Text('Articles  not found.'));
          }

          return _countriesView(result);
        },
      ),
    );
  }
  
  ListView _countriesView(QueryResult result) {
    final countryList = result.data['article'];
    return ListView.separated(
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(countryList[index]['title']),
           subtitle: Text(countryList[index]['author']['name']),
          // leading: Text(countryList[index]['emoji']),
          onTap: () {
            final snackBar = SnackBar(
                content:
                    Text('Selected Country: ${countryList[index]['title']}'));
            Scaffold.of(context).showSnackBar(snackBar);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
