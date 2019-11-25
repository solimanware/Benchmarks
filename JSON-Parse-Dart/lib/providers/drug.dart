import 'package:dawaey/types/drug.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Drug>>fetchDrugs() async{
  var response = await http.get('https://dawaey.com/api/v3/eg/drugs.json');
  List<Drug> drugs;
  var drugsJSON;

  //one time benchmark
  BenchmarkMS("JSON parse",(){
    drugsJSON = json.decode(response.body)['drugs'] as List;
  });

  //100 times benchmark
  BenchmarkOnScale("JSON parse",100,(){
    drugsJSON = json.decode(response.body)['drugs'] as List;
  });

  drugs = drugsJSON.map((model)=> Drug.fromJson(model)).toList();
  return drugs;
}

int BenchmarkMS(name, block){
  var start = new DateTime.now().millisecondsSinceEpoch;
  block();
  var end = new DateTime.now().millisecondsSinceEpoch;
  print("Benchmark took " + (end-start).toString());
  return end - start;
}

void BenchmarkOnScale(String name,int times,block){
  var totalTime = 0;
  for (var i = 0; i < times; i++) {
    totalTime = totalTime + BenchmarkMS(name, (){
      block();
    });
  }
  var avarage = totalTime / times;
  print('Total of invoking '+ name + " "+ times.toString()+ ' times '+ 'took '+ avarage.toString());
}