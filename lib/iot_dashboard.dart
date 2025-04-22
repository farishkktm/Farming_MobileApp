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
      body: temperature == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDataCard("Temperature", "$temperature °C", Icons.thermostat, Colors.red),
          _buildDataCard("Humidity", "$humidity %", Icons.water_drop, Colors.blue),
          _buildDataCard("Soil Moisture", "$moisture %", Icons.grass, Colors.brown),
          _buildDataCard(
              "IR Sensor",
              irStatus == "1" ? "Obstacle Detected" : "Clear",
              Icons.sensors,
              irStatus == "1" ? Colors.purple : Colors.green),
          const SizedBox(height: 30),

          Text('Pump Control', style: GoogleFonts.electrolize(fontSize: 20, fontWeight: FontWeight.bold)),

          Card(
            color: Colors.lightBlue,
            margin: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text('Pump',
                    style: GoogleFonts.electrolize(
                        fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                trailing: Switch(
                  value: pumpSwitch,
                  onChanged: (bool value) => updatePumpSwitch(value),
                  activeColor: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(String title, String value, IconData icon, Color iconColor) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
