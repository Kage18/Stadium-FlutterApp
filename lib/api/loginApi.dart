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

  return result;
}
