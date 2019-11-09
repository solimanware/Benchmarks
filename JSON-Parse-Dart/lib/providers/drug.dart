import 'package:dawaey/types/drug.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Drug>>fetchDrugs() async{
  var response = await http.get('https://dawaey.com/api/v3/eg/drugs.json');
  List<Drug> drugs;
  print("hi");
  BenchmarkMS((){
    var l = json.decode(response.body)['drugs'] as List;
    drugs = l.map((model)=> Drug.fromJson(model)).toList();
  });
  return drugs;
}

void BenchmarkMS(block){
  var start = new DateTime.now().millisecondsSinceEpoch;
  block();
  var end = new DateTime.now().millisecondsSinceEpoch;
  print("****************************");
  print("Benchmark took " + (end-start).toString());
  print("****************************");
}