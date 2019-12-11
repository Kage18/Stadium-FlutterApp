import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';

Future<QueryResult> getAllFriendsApi() async {
  String allFriends = '''

     query {
    me{
        id
        DOB
        gender
        phoneNo
        bio
        joined
        Customer{
            username
        }
        friends{
            id
            DOB
            gender
            phoneNo
            bio
            joined
            Customer{
                username
            }
        }
    }
}

    ''';
  print(allFriends);

  print("/*-/*-/*-/*-Trying to get Data/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.query(
    QueryOptions(
      document: allFriends,
    ),
  );

  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");

  print(result.data.data);
  return result;
}

Future<QueryResult> getAllPendingRequests() async {
  String allPendingRequests = '''
query {
    pendingRequests {
        id
        fromUser{
            Customer{
                username
                email
            }
        }
    }
}

    ''';
  print(allPendingRequests);

  print("/*-/*-/*-/*-Trying to get Data/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.query(
    QueryOptions(
      document: allPendingRequests,
    ),
  );

  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");

  print(result.data.data);
  return result;
}

Future<QueryResult> sendFriendRequest(String toUserEmail) async {
  String sendRequest = '''

      mutation{
    sendFriendRequest(toUserEmail: "${toUserEmail}") {
      fromUser{id}
    }
  }

    ''';
  print(sendRequest);

  print("/*-/*-/*-/*-Trying to buy game/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.mutate(
    MutationOptions(
      document: sendRequest,
    ),
  );
  //print(json.decode(result.data.data));
  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");
  return result;
}
