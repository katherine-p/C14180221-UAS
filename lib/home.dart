import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class myhome extends StatefulWidget {
  final int id;
  myhome(this.id);  

  @override
  _myhomeState createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
  var datauser;
  List <dynamic> userposts = [];

  @override
  void initState() {
    this.getdata();
    this.getpost();
    super.initState();
  }

  Future<String> getdata() async {
    var iduser = widget.id.toString();
    final String urlAPI = "https://jsonplaceholder.typicode.com/users/"+ iduser;
    var apiresult = await http.get(Uri.parse(urlAPI));

    setState(() {
      var jsonObject = json.decode(apiresult.body);
      datauser = (jsonObject as Map<String, dynamic>);
      print(datauser);
    });    
  }

  Future<String> getpost() async {
    List <dynamic> post = [];
    var iduser = widget.id.toString();
    final String urlAPI = "https://jsonplaceholder.typicode.com/posts/";
    var apiresult = await http.get(Uri.parse(urlAPI));

    setState(() {
      var jsonObject = json.decode(apiresult.body);
      post = jsonObject;
      // print(post);
      for(var i = 0; i < post.length; i++)
      {
        if(post[i]['userId'].toString() == iduser)
        {
          print('gotthemmm');
          userposts.add(jsonObject[i]);
          print(post[i]);
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
        iconTheme: IconThemeData(color: Colors.black,),
      ),
      backgroundColor: Colors.green[200],
      body: Container(
        child: Center(
          child: Column(
            children: <Widget> [
              SizedBox(height: 30),
              Text((datauser != null) ? "Hello, ${datauser['name']}" : "",),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text('My Posts'),
                onPressed: (){
                  Navigator.pushNamed(context, '/post', arguments: widget.id);                  
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text('My To Do List'),
                onPressed: (){
                  Navigator.pushNamed(context, '/todo', arguments: widget.id);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}