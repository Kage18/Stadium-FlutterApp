import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';

Future<QueryResult> login(String email, String password) async {
  String loginMutation = '''

      mutation{

          tokenAuth(email: "$email", password: "$password"){

            token

          }

      }

    ''';
  print(loginMutation);

  print("/*-/*-/*-/*-Trying to login/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.mutate(
    MutationOptions(
      document: loginMutation,
    ),
  );
  //print(json.decode(result.data.data));
  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");

  //print(result.data.data['tokenAuth']['token']);
  //print(result.errors[0]);

  // print(result.data.data['tokenAuth']['token']);
  return result;
  /* print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
  if(result.data.error){
    return null;
  }
  if(result.data.data['tokenAuth'] == null){
    return null;
  }
else{
  return(result.data.data['tokenAuth']['token']);}*/
}
