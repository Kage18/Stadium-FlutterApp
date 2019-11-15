import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stadium/ui/landingPage.dart';
import 'package:stadium/graphQlConf.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() async =>
    //WidgetsFlutterBinding.ensureInitialized();

    runApp(GraphQLProvider(
      client: graphQLConfiguration.client,
      child: CacheProvider(child: MyApp()),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stadium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}
