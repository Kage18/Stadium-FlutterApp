import 'dart:convert';

Parameter clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Parameter.fromMap(jsonData);
}

String clientToJson(Parameter data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Parameter {
  String parameterName;
  String parameterValue;

  Parameter({this.parameterName, this.parameterValue});

  factory Parameter.fromMap(Map<String, dynamic> json) => new Parameter(
        parameterName: json["parameterName"],
        parameterValue: json["parameterValue"],
      );

  Map<String, dynamic> toMap() => {
        "parameterName": parameterName,
        "parameterValue": parameterValue,
      };
}
