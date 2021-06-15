import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class mypost extends StatefulWidget {
  final int id;
  mypost(this.id);  

  @override
  _mypostState createState() => _mypostState();
}

class _mypostState extends State<mypost> {
  List <dynamic> userposts = [];

  @override
  void initState() {
    this.getpost();
    super.initState();
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
      backgroundColor: Colors.green[100],
      body: Container(
        child: Center(
          child: Column(
            children: <Widget> [
              SizedBox(height: 40),
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: new ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: (userposts != null ? userposts.length : 0),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.green[200],
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(userposts[index]['title'].toString()),
                              subtitle: Text(userposts[index]['body'],style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                            )
                          ]
                        )                        
                      );
                    }),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}