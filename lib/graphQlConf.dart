import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:stadium/config/config.dart';

import 'database.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(uri: serverApi);

  static AuthLink authLink = AuthLink(getToken: () async {
    print(
        "----------------------------Trying to get token in grapgQL config-----------------");

    dynamic tok = await DBProvider.db.getParameter('Token');
    print(tok);
    //print(tok.parameterValue);

    print(
        "----------------------------Got Token successfully from grapgqlConfig-----------------");
    //print(tok.parameterValue);
    if (tok == Null) {
      print("Token is null ..Sorry bruh");
      return "";
    } else {
      return (tok.parameterValue);
    }
  }
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
      );

  static Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: link,
    );
  }
}
