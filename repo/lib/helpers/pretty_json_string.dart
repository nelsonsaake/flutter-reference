import 'dart:convert';

String prettyJSONString(jsonObject){
   var encoder = const JsonEncoder.withIndent("     ");
   return encoder.convert(jsonObject);
}