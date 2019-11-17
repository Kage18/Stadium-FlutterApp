import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../main.dart';

Future<QueryResult> signup(String username, String email, String password, String dob, String phone, int gender) async {
  String signupMutation = '''

      mutation{

          createUser(email: "$email", password: "$password", username: "$username", DOB: "$dob", phoneNo: "$phone", gender: $gender){

            user{
              username
              }
          }

      }

    ''';
  print(signupMutation);

  print("/*-/*-/*-/*-Trying to Signup/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.mutate(
    MutationOptions(
      document: signupMutation,
    ),
  );
  //print(json.decode(result.data.data));
  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");

  //print(result.data.data);
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
