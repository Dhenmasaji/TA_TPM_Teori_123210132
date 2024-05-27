import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final String apiName;
  final bool status;
  final String documentationUrl;
  final String developerName;
  final String description;

  DetailPage({
    required this.apiName,
    required this.status,
    required this.documentationUrl,
    required this.developerName,
    required this.description,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? selectedApi;
  int rentalMonths = 1;
  double rentalPricePerMonth = 500000;
  double totalPrice = 0.0;
  final exchangeRates = {
    'MYR': 0.23,
    'SGD': 0.000093,
    'THB': 0.0022,
  };

  void calculateTotalPrice() {
    setState(() {
      totalPrice = rentalPricePerMonth * rentalMonths;
    });
  }

  double convertToCurrency(String currencyCode) {
    return totalPrice * (exchangeRates[currencyCode] ?? 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apiName),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(
                  widget.status ? Icons.check_circle : Icons.cancel,
                  color: widget.status ? Colors.green : Colors.red,
                ),
                title: Text(
                  'Status: ${widget.status ? 'Active' : 'Inactive'}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Documentation URL:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: GestureDetector(
                  onTap: () async {
                    if (await canLaunch(widget.documentationUrl)) {
                      await launch(widget.documentationUrl);
                    } else {
                      throw 'Could not launch ${widget.documentationUrl}';
                    }
                  },
                  child: Text(
                    widget.documentationUrl,
                    style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Developer:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  widget.developerName,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  widget.description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Pilih API yang mau disewa:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: DropdownButton<String>(
                  value: selectedApi,
                  hint: Text('Pilih API'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedApi = newValue;
                    });
                  },
                  items: <String>['Blibli', 'Lazada', 'Shopee', 'Matahari Mall API for seller', 'Tokopedia.com API']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Lama Penyewaan (Bulan):',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'masukkan lama dalam bulan',
                  ),
                  onChanged: (value) {
                    setState(() {
                      rentalMonths = int.tryParse(value) ?? 1;
                      calculateTotalPrice();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Total Harga (Rupiah):',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Rp$totalPrice',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Total harga dalam ringgit:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'RM${convertToCurrency('MYR').toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Total harga dalam dollar singapore:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'S\$${convertToCurrency('SGD').toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  'Total harga dalam bath:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '฿${convertToCurrency('THB').toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
