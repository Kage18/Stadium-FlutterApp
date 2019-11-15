import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:stadium/config/config.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    uri: serverApi
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}