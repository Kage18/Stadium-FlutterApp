import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stadium/config/config.dart';

Future<dynamic> getContainerUrl(String gameId, String userId) async {
  final String url = serverUrl + "/container/"+ gameId.toString() + "/"+ userId.toString();
print(url);
  var response = await http.get(Uri.encodeFull(url));
  print(response.statusCode);
  
  if (response.statusCode == 200) {
    final inJson = json.decode(response.body);
    
    
    print(inJson);
  return inJson;
  } else {
    final inJson = json.decode(response.body);
    print(inJson);
  }

}