import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../main.dart';

Future<QueryResult> profileData() async {
  String profile = '''

      query{
          me{
            Customer{username}
              id 
              DOB
              gender
              phoneNo
              bio
              joined
              avatar{
                url
              } 
            }
          }

    ''';
  print(profile);

  print("/*-/*-/*-/*-Trying to get Data/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.query(
    QueryOptions(
      document: profile,
    ),
  );

  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");

  //print(result.data.data);
  //print(result.errors[0]);
//print(result.data.data);
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

Future<QueryResult> getUserId() async {
  String getUserId = '''

      query{
          me{
            Customer{username}
              id 
            }
          }

    ''';
  //print(signupMutation);

  print("/*-/*-/*-/*-Trying to get UserId/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.query(
    QueryOptions(
      document: getUserId,
    ),
  );

  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");

  //print(result.data.data);
  // print(result.errors[0]);
//print(result.data.data);
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
