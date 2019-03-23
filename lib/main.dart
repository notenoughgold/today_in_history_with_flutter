import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:today_in_history/today.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _chosenDate = new DateTime.now();
  Future<Today> today;
  final baseUrl = "https://history.muffinlabs.com/date/";

  Future<Today> _fetchTodayInHistory(month, day) async {
    var fetchUrl = baseUrl + month + "/" + day;
    var response = await http.get(fetchUrl);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var todayObj = Today.fromJson(json.decode(response.body));
      return todayObj;
    } else {
      // If that response was not OK, throw an error.
      print("loading failed");
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    today = _fetchTodayInHistory(
        _chosenDate.month.toString(), _chosenDate.day.toString());
  }

  _chooseDate() async {
    var _newlyChosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year, 1, 1),
      lastDate: DateTime(DateTime.now().year, 12, 31),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (_newlyChosenDate != _chosenDate) {
      setState(() {
        _chosenDate = _newlyChosenDate;
        today = null;
        today = _fetchTodayInHistory(
            _chosenDate.month.toString(), _chosenDate.day.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("History In " +
              _chosenDate.month.toString() +
              "/" +
              _chosenDate.day.toString()),
          bottom: TabBar(tabs: [
            Tab(
              text: "Events",
            ),
            Tab(
              text: "Births",
            ),
            Tab(
              text: "Deaths",
            ),
          ]),
        ),
        body: TabBarView(children: [
          _createTabView(0),
          _createTabView(1),
          _createTabView(2)
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: _chooseDate,
          tooltip: "Choose a date",
          child: Icon(Icons.today),
        ),
      ),
    );
  }

  _createTabView(int whichTab) {
    //get the right json object from the common future snapshot for 3 different tabs.
    _getPartOfSnapshot(int whichTab, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) return null;

      switch (whichTab) {
        case 0:
          return snapshot.data.data.events;
        case 1:
          return snapshot.data.data.births;
        case 2:
          return snapshot.data.data.deaths;
      }
    }

    return Center(
      child: FutureBuilder<Today>(
        future: today,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemBuilder: (context, position) {
              return Card(
                child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        _getPartOfSnapshot(whichTab, snapshot)[position].year,
                        style: new TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                          _getPartOfSnapshot(whichTab, snapshot)[position]
                              .text),
                    )),
              );
            },
            itemCount: snapshot.data.data.events.length,
          );
        },
      ),
    );
  }
}
