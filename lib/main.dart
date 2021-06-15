import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'post.dart';
import 'todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(),
        '/home': (context) => myhome(ModalRoute.of(context).settings.arguments as int),
        '/post': (context) => mypost(ModalRoute.of(context).settings.arguments as int),
        '/todo': (context) => todolist(ModalRoute.of(context).settings.arguments as int)
      },
      theme: ThemeData(
        textTheme: GoogleFonts.robotoMonoTextTheme((Theme.of(context).textTheme)
      ),
    )
    );
  }
}

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List <dynamic> users = [];
  final _username = TextEditingController();
  final _pass = TextEditingController();

  Future<String> connectToAPI() async {
    final String urlAPI = "https://jsonplaceholder.typicode.com/users";
    var apiresult = await http.get(Uri.parse(urlAPI));

    setState(() {
      var jsonObject = json.decode(apiresult.body);
      users = jsonObject;
    });
  }

  @override
  void initState() {
    this.connectToAPI();
    super.initState();
  }

  void ceklogin()
  {
    setState(() {
      var cek = 0;      
      print(users[0]['username']);

      for (var i = 0; i < users.length; i++)
      {
        if(users[i]['username'] == _username.text)
        {
          print('login success');
          cek = 1;
          Navigator.pushNamed(context, '/home', arguments: users[i]['id']);
        }
      }

      if(cek == 0)
      {
        print('cant find user');
        final snackBar = SnackBar(content: Text('Wrong username or password.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: new Center(child: Text('Its Me', style: TextStyle(color: Colors.black))),
        backgroundColor: Colors.green[50],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Image.network("https://cdn.iconscout.com/icon/free/png-256/social-media-2125943-1789238.png", width: 200),
              SizedBox(height: 20),
              TextField(
                controller: _username,
                decoration: InputDecoration(hintText: "Input your username", labelText: "Username"),
              ),
              TextField(
                controller: _pass,
                decoration: InputDecoration(hintText: "Input your password", labelText: "Password"),
                obscureText: true
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: ceklogin, 
                    child: Text("Login", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),
                  ),
                ],
              ),
            ],
          ),
          
        ),        

      )
    );
  }
}