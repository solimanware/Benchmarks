import 'dart:developer';

import 'package:dawaey/providers/drug.dart';
import 'package:dawaey/types/drug.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:diff_match_patch/diff_match_patch.dart';


class _DrugPageState extends State<DrugPage> {
  List<Drug> drugs;
  String term = "";
  bool _visible = false;
  StreamController controller = new StreamController<List<Drug>>.broadcast();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDrugs().then((data){
      drugs = data;
    });
    controller.addStream(fetchDrugs().asStream());
  }

  getStream() {
    return controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        searchCard(),
        SizedBox(
          height: MediaQuery.of(context).size.height - 30,
          child: drugStreamList(),
        )
      ],
    );
  }



  doSearch(List<Drug> data, term) {
    normalFilter(Drug drug) => drug.tradename.toLowerCase().toString().contains(term);
    fussyFilter(Drug drug){
      var matcher = new DiffMatchPatch();
      matcher.matchThreshold = 0.3;
      matcher.matchDistance = 14;
      return matcher.match(drug.tradename.toLowerCase().toString(), term, 0) >-1?true:false;
    }

    List<Drug> filteredList = data.where(normalFilter).toList();

    //found results
    if(filteredList.length >= 1){
      controller.add(filteredList);
    }else{
      //didn't find
      List<Drug> fussyList = data.where(fussyFilter).toList();
      controller.add(fussyList);
    }
  }

  onTextChanged(text){
    doSearch(drugs, text);
    term = text;
    log(term);
    log(term.length.toString());
  }

  Widget searchCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.search),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Search for drug..."),
                  onChanged: onTextChanged,
                ),
              ),
              Icon(Icons.menu),
            ],
          ),
        ),
      ),
    );
  }

  Widget drugListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Drug> values = snapshot.data;
    return new ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return drugCard(values[index]);
      },
    );
  }

  Widget drugStreamList() {
    return new StreamBuilder<List<Drug>>(
      stream: getStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Status: none');
          case ConnectionState.waiting:
            return Text('Loading...');
          case ConnectionState.active:
            return drugListView(context, snapshot);
        //add data here
          case ConnectionState.done:
            return drugListView(context, snapshot);
        }
        return null; //unreachable
      },
    );
  }


  Widget drugCard(Drug drug) {
    return new Column(
      children: <Widget>[
        new ListTile(
            leading: Icon(Icons.healing),
            title: Text(drug.tradename,overflow: TextOverflow.ellipsis,),
            subtitle: drug.activeingredient.length != null
                ? Text(drug.activeingredient,overflow: TextOverflow.ellipsis,)
                : null),
        new Divider(
          height: 2.0,
        ),
      ],
    );
  }
}

class DrugPage extends StatefulWidget {
  @override
  _DrugPageState createState() => new _DrugPageState();
}