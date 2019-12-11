import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../main.dart';

Future<QueryResult> allGames() async {
  String allGames = '''

      query{
          games{
              id 
              name
              description
              price
              gameOwnedSet{
                customer{
                  Customer{
                    username
                  }
                  id
                }
              }
              images{
                url
              } 
            }
          }

    ''';
  //print(signupMutation);

  print("/*-/*-/*-/*-Trying to get Data/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.query(
    QueryOptions(
      document: allGames,
    ),
  );

  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");

  //print(result.data.data);
  //print(result.errors[0]);
  print(result.data.data);
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

Future<QueryResult> getLibrary(int id) async {
  String getLibrary = '''

      query{
          gameOwned(userId: $id){
            game{
              id
              name
            }
            hoursPlayed
            rating
            customer{
              id
              Customer{
                username
              }
            }
            }
          }

    ''';
  //print(signupMutation);

  print("/*-/*-/*-/*-Trying to get Data/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.query(
    QueryOptions(
      document: getLibrary,
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

Future<QueryResult> buyGame(String gameId) async {
  String buyGame = '''

      mutation {
        buyGame(gameId: $gameId){
            transaction{
              id
              amount
            }
            gameowned{
              id
              customer{
                Customer{
                  id 
                  username
                }
              }
            }
        }
        }
          

    ''';
  print(buyGame);

  print("/*-/*-/*-/*-Trying to buy game/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.mutate(
    MutationOptions(
      document: buyGame,
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
