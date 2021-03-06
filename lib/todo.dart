import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class todolist extends StatefulWidget {
  final int id;
  todolist(this.id);

  @override
  _todolistState createState() => _todolistState();
}

class _todolistState extends State<todolist> {
  List<dynamic> userTodo = [];
  bool checkin;

  @override
  void initState() {
    this.get_todo();
    super.initState();
  }

  Future<String> get_todo() async {
    List<dynamic> listTodo = [];
    var iduser = widget.id.toString();
    final String urlAPI = "https://jsonplaceholder.typicode.com/todos/";
    var apiresult = await http.get(Uri.parse(urlAPI));

    setState(() {
      var jsonObject = json.decode(apiresult.body);
      listTodo = jsonObject;
      print(jsonObject);
      for (var i = 0; i < listTodo.length; i++) {
        if (listTodo[i]['userId'].toString() == iduser) {
          print('gotthemmm');
          userTodo.add(jsonObject[i]);
          print(listTodo[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.green[50],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.green[100],
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text('To Do List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 40),
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: new ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: (userTodo != null ? userTodo.length : 0),
                    itemBuilder: (BuildContext context, int index) {
                      var check = userTodo[index]['completed'];
                      print(check);
                      return CheckboxListTile(
                        title: Text(userTodo[index]['title'].toString()),
                        value: check, 
                        onChanged: (bool val){
                          setState(() {
                            check = val;
                          });                          
                        }
                      );
                    }
                  )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
