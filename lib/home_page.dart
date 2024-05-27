import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'login_page.dart';
import 'session.dart';
import 'saran_page.dart';
import 'detail_page.dart';
import 'time_converter_page.dart';
import 'profil_page.dart'; // Import the ProfilPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<dynamic>> _fetchData() async {
    final response = await http.get(Uri.parse('https://dhenmasaji.github.io/e_commerce_api/e_commerce.json'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['apis'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  _logout(BuildContext context) async {
    await SessionManager().setLoggedIn(false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  _reviewDocumentation(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blue, // Warna AppBar disesuaikan
        actions: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () {
              // Tambahkan fungsi ketika ikon ditekan
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final apis = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: apis.length,
              itemBuilder: (context, index) {
                final api = apis[index];
                final apiName = api['apiName'];
                final status = api['status'];
                final documentationUrl = api['documentationUrl'];
                final developerName = api['developer']['name'];
                final description = api['description'];

                return Card(
                  elevation: 5, // Tambahkan bayangan Card
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Atur margin Card
                  child: ListTile(
                    title: Text(apiName, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(developerName),
                    trailing: ElevatedButton(
                      onPressed: () => _reviewDocumentation(documentationUrl),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Review', style: TextStyle(color: Colors.redAccent)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            apiName: apiName,
                            status: status,
                            documentationUrl: documentationUrl,
                            description: description,
                            developerName: developerName,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue, // Warna BottomNavigationBar disesuaikan
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.logout, color: Colors.white),
                onPressed: () => _logout(context),
              ),
              IconButton(
                icon: Icon(Icons.feedback, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SaranPage()),
                  );
                },
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/profil.jpg'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.access_time, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeConverterPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
