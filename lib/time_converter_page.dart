import 'package:flutter/material.dart';

class TimeConverterPage extends StatefulWidget {
  @override
  _TimeConverterPageState createState() => _TimeConverterPageState();
}

class _TimeConverterPageState extends State<TimeConverterPage> {
  final TextEditingController _wibController = TextEditingController();
  String _result = '';

  void _convertTime() {
    try {
      final TimeOfDay wibTime = TimeOfDay(
        hour: int.parse(_wibController.text.split(':')[0]),
        minute: int.parse(_wibController.text.split(':')[1]),
      );

      final TimeOfDay witaTime = wibTime.replacing(hour: (wibTime.hour + 1) % 24);
      final TimeOfDay witTime = wibTime.replacing(hour: (wibTime.hour + 2) % 24);

      setState(() {
        _result = 'WITA: ${witaTime.format(context)}\nWIT: ${witTime.format(context)}';
      });
    } catch (e) {
      setState(() {
        _result = 'Format salah , harap masukkan yang benar';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Converter'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _wibController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'masukkan jam  (HH:mm)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTime,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                textStyle: TextStyle(fontSize: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: TimeConverterPage(),
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
));
