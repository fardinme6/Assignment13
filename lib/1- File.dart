import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(File1());

class File1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FileReadWriteScreen(),
    );
  }
}

class FileReadWriteScreen extends StatefulWidget {
  @override
  _FileReadWriteScreenState createState() => _FileReadWriteScreenState();
}

class _FileReadWriteScreenState extends State<FileReadWriteScreen> {
  TextEditingController _controller = TextEditingController();
  String _fileContent = "";

  Future<void> _saveToFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');
      await file.writeAsString(_controller.text);
      setState(() {
        _fileContent = "فایل ذخیره شد!";
      });
    } catch (e) {
      setState(() {
        _fileContent = "خطا: $e";
      });
    }
  }

  Future<void> _readFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');
      String content = await file.readAsString();
      setState(() {
        _fileContent = content;
      });
    } catch (e) {
      setState(() {
        _fileContent = "خطا: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('خواندن و نوشتن فایل')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'متن خود را وارد کنید',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveToFile,
              child: Text('ذخیره در فایل'),
            ),
            ElevatedButton(
              onPressed: _readFromFile,
              child: Text('خواندن از فایل'),
            ),
            SizedBox(height: 20),
            Text(
              'محتوای فایل:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_fileContent),
          ],
        ),
      ),
    );
  }
}
