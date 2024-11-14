import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrcode/qr_code_history_screen.dart';
import 'package:qrcode/qr_generator_screen.dart';
import 'package:qrcode/qr_scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: SingleChildScrollView(  // Allow scrolling if content overflows
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02), // 2% of screen height
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.06), // 6% of screen width
                child: Text(
                  "Qr Code Pro",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.08, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 3% of screen height
              Center(
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.08), // 8% of screen width
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildFeatureButton(
                        context,
                        "Generate QR Code",
                        Icons.qr_code,
                            () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QRGeneratorScreen()),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02), // 2% of screen height
                      _buildFeatureButton(
                        context,
                        "Scan QR Code",
                        Icons.qr_code_scanner,
                            () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QrScannerScreen(data: '')),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02), // 2% of screen height
                      Container(
                        height: screenHeight * 0.22, // 22% of screen height
                        width: screenWidth * 0.6, // 60% of screen width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QRHistoryScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history, size: screenWidth * 0.2, color: Colors.white), // Scalable icon size
                              SizedBox(height: screenHeight * 0.01), // 1% of screen height
                              Text(
                                "View QR Code History",
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.05, // Scalable font size
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.06), // 6% of screen width
        height: screenHeight * 0.22, // 22% of screen height
        width: screenWidth * 0.6, // 60% of screen width
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: screenWidth * 0.2, color: Colors.white), // Scalable icon size
            SizedBox(height: screenHeight * 0.01), // 1% of screen height
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.05, // Scalable font size
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
