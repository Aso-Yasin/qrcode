import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'database_helper.dart'; // Adjust if needed

class QRHistoryScreen extends StatefulWidget {
  @override
  _QRHistoryScreenState createState() => _QRHistoryScreenState();
}

class _QRHistoryScreenState extends State<QRHistoryScreen> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await DatabaseHelper().getHistory();
    setState(() {
      history = data;
    });
  }

  void _showHistoryDetails(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("QR Code Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Type: ${item['type']}"),
              SizedBox(height: 8),
              SelectableText("Data: ${item['data']}"),
              SizedBox(height: 8),
              Text("Scanned on: ${item['timestamp']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
            TextButton(
              onPressed: () {
                Share.share(item['data']);
              },
              child: Text("Share"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code History"),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            title: Text(item['type'].toUpperCase()),
            subtitle: Text(
              item['data'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              item['timestamp'].toString().split("T").join(" "),
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () => _showHistoryDetails(item),
          );
        },
      ),
    );
  }
}
