import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ShPreference());
}

class ShPreference extends StatefulWidget {
  @override
  ShPreferenceState createState() => ShPreferenceState();
}

class ShPreferenceState extends State<ShPreference> {
  final TextEditingController _controller = TextEditingController();
  String _savedName = "";

  @override
  void initState() {
    super.initState();
    _loadSavedName();
  }


  Future<void> _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _controller.text);
    setState(() {
      _savedName = _controller.text;
    });
  }

 
  Future<void> _loadSavedName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString('name') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Shared Preferences Demo'),
        leading: GestureDetector(child: Icon(Icons.arrow_back_ios_new),
        onTap: (){
          Navigator.pop(context);
        },),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Enter your name'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveName,
                child: Text('Save Name'),
              ),
              SizedBox(height: 20),
              Text(
                _savedName.isNotEmpty
                    ? 'Saved Name: $_savedName'
                    : 'No name saved yet',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
