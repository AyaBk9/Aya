import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:project2/Game.dart';


const String _baseURL = 'https://ayabk9.000webhostapp.com/CSCI410Fall2023/';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _Key = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  bool _loading = false;


  @override
  void dispose() {
    _controllerName.dispose();
    _controllerAge.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
        appBar: AppBar(
          title: const Text('Add Player'),
          backgroundColor: Colors.red,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child:
            Form(
              key: _Key,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  SizedBox(width: 200,
                      child:
                      TextFormField(controller: _controllerName,
                        cursorColor: Colors.red,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red), // Border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red), // Focused border color
                            borderRadius: BorderRadius.circular(10),// Border radius
                          ),
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(color: Colors.red),
                ),
                        validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                },
              )),
                  const SizedBox(height: 10),
                  SizedBox(width: 200,
                      child:
                      TextFormField(controller: _controllerAge,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.red,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red), // Border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red), // Focused border color
                            borderRadius: BorderRadius.circular(10),// Border radius
                          ),
                          hintText: 'Enter Age',
                          hintStyle: TextStyle(color: Colors.red),
                        ),
                        validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                        },
                      )),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),// Border color
                      elevation: 5, // Elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Border radius
                      ),
                    ),
                    onPressed: _loading ? null : () {
                      if (_Key.currentState!.validate()) {
                        setState(() {
                          _loading = true;
                        });
                        addPlayer(update, _controllerName.text, int.parse(_controllerAge.text));}
                      },
                    child: const Text('Submit'),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),// Border color
                      elevation: 5, // Elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Border radius
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Game()));
                      },
                    child: const Text('Start'),
                  ),
                  const SizedBox(height: 10),
                  Visibility(visible: _loading, child: const CircularProgressIndicator())
                ],
              ),
            )));
  }
}

void addPlayer(Function(String text) update,String name, int age) async {
  try {
    final response = await http.post(
        Uri.parse('$_baseURL/addPlayer.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, String>{
          'name': name, 'age': '$age','key': 'your_key'
        })).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      update(response.body);
    }
  }
  catch(e) {
    update(e.toString());
  }
}