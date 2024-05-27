import 'package:flutter/material.dart';

class SaranPage extends StatefulWidget {
  @override
  _SaranPageState createState() => _SaranPageState();
}

class _SaranPageState extends State<SaranPage> {
  final _saranController = TextEditingController();
  final _kesanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Saran Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 57,
                vertical: 5,
              ),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Pesan : Terima kasih telah mengajarkan saya pengetahuan tentang Pemrograman Mobile ,Saya akan selalu mengingat momen-momem yang saya dapat di sini dan akan menggunakannya sebagai dasar untuk masa depan yang cerah dan menjanjikan.',
                          style: TextStyle(decoration: TextDecoration.none,color: Colors.black,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Kesan : Saya merasa sangat senang  saat  belajar pemrograman mobile di kampus. Selama perkuliahan, saya mempelajari berbagai macam konsep dan teknologi yang sangat menarik dan berguna, seperti Flutter dan Dart.Saya sangat menikmati proses pembelajaran ini, karena saya dapat mengimplementasikan konsep-konsep teoritis ke dalam kode yang dapat dijalankan. Selain itu, saya juga dapat bekerja sama dengan teman-teman saya dalam mengerjakan proyek-proyek kecil, yang membantu saya untuk memahami lebih dalam tentang pengembangan aplikasi mobile.',
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.none,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}