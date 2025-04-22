import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class IotDashboardPage extends StatefulWidget {
  const IotDashboardPage({super.key});

  @override
  State<IotDashboardPage> createState() => _IotDashboardPageState();
}

class _IotDashboardPageState extends State<IotDashboardPage> {
  final DatabaseReference myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://farming-eb778-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  double? temperature;
  double? humidity;
  double? moisture;
  String? irStatus;
  bool pumpSwitch = false;

  @override
  void initState() {
    super.initState();

    // Sensor Listener
    myRTDB.child("Sensor").onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          temperature = (data['temperature'] as num?)?.toDouble();
          humidity = (data['humidity'] as num?)?.toDouble();
          moisture = (data['moisture'] as num?)?.toDouble();
          irStatus = data['ir']?.toString();
        });
      }
    });

    // Pump Switch Listener
    readSwitchStatus();
  }

  void readSwitchStatus() {
    myRTDB.child('Actuator/pump').onValue.listen((event) {
      setState(() {
        pumpSwitch = event.snapshot.value as bool? ?? false;
      });
    });
  }

  void updatePumpSwitch(bool value) {
    myRTDB.child('Actuator/pump').set(value);
    setState(() {
      pumpSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: temperature == null
          ? Center(child: CircularProgressIndicator(color: Colors.green[800]))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Text('Field Conditions',
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[800])),
            SizedBox(height: 16),

            // Sensor Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildSensorCard(
                    context,
                    "Temperature",
                    "$temperature°C",
                    Icons.thermostat,
                    Colors.red[400]!,
                    LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.red[100]!, Colors.white])),
                _buildSensorCard(
                    context,
                    "Humidity",
                    "$humidity%",
                    Icons.water_drop,
                    Colors.blue[400]!,
                    LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue[100]!, Colors.white])),
                _buildSensorCard(
                    context,
                    "Soil Moisture",
                    "$moisture%",
                    Icons.grass,
                    Colors.brown[400]!,
                    LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.brown[100]!, Colors.white])),
                _buildSensorCard(
                    context,
                    "IR Sensor",
                    irStatus == "1" ? "Obstacle" : "Clear",
                    Icons.sensors,
                    irStatus == "1" ? Colors.purple[400]! : Colors.green[400]!,
                    LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          irStatus == "1"
                              ? Colors.purple[100]!
                              : Colors.green[100]!,
                          Colors.white
                        ])),
              ],
            ),
            SizedBox(height: 24),

            // Pump Control Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Irrigation Control',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[800])),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.opacity,
                          size: 30,
                          color: Colors.blue[800]),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Water Pump',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                      Transform.scale(
                        scale: 1.3,
                        child: Switch(
                          value: pumpSwitch,
                          onChanged: (value) => updatePumpSwitch(value),
                          activeTrackColor: Colors.green[300],
                          activeColor: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: moisture != null ? moisture! / 100 : 0,
                    backgroundColor: Colors.grey[200],
                    color: moisture != null
                        ? moisture! < 30
                        ? Colors.red[400]
                        : moisture! < 60
                        ? Colors.orange[400]
                        : Colors.green[400]
                        : Colors.grey,
                    minHeight: 8,
                  ),
                  SizedBox(height: 4),
                  Text(
                    moisture != null
                        ? 'Soil moisture is ${moisture! < 30 ? 'low' : moisture! < 60 ? 'moderate' : 'good'}'
                        : 'Reading moisture...',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Status Summary
            if (irStatus == "1")
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange[200]!)),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.orange[800]),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text('Obstacle detected in field!',
                          style: GoogleFonts.poppins(
                              color: Colors.orange[800])),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard(BuildContext context, String title, String value,
      IconData icon, Color iconColor, Gradient gradient) {
    return Container(
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2))
          ]),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  shape: BoxShape.circle),
              child: Icon(icon, size: 28, color: iconColor),
            ),
            SizedBox(height: 12),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700])),
            SizedBox(height: 4),
            Text(value,
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900])),
          ],
        ),
      ),
    );
  }
}
