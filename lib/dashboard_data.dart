import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const AgroTechApp());
}

class AgroTechApp extends StatelessWidget {
  const AgroTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgroTech App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    DashboardPage(),
    DeveloperProfilePage(),
    HelpSupportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Dashboard'
              : _currentIndex == 1
              ? 'Developer Profile'
              : 'Help & Support',
        ),
      ),
      body: _pages[_currentIndex],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green[800],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.spa, size: 40, color: Colors.green),
                ),
                const SizedBox(height: 10),
                Text(
                  'AgroTech App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.green),
            title: const Text('Dashboard'),
            onTap: () => _navigateToPage(0),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.green),
            title: const Text('Developer Profile'),
            onTap: () => _navigateToPage(1),
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.green),
            title: const Text('Help & Support'),
            onTap: () => _navigateToPage(2),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    Navigator.pop(context);
    setState(() => _currentIndex = index);
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool pumpAutoMode = true;
  bool pumpStatus = false;
  final double humidity = 65.3;
  final double temperature = 27.8;
  final double soilMoisture = 42.1;
  final double waterLevel = 75.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPumpControlCard(),
          const SizedBox(height: 20),
          _buildSensorGrid(),
          const SizedBox(height: 20),
          _buildSensorGraphs(),
        ],
      ),
    );
  }

  Widget _buildPumpControlCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Water Pump Control',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                Switch(
                  value: pumpAutoMode,
                  onChanged: (value) => setState(() => pumpAutoMode = value),
                  activeColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              pumpAutoMode ? 'Auto Mode (Enabled)' : 'Manual Mode',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            if (!pumpAutoMode)
              ElevatedButton(
                onPressed: () => setState(() => pumpStatus = !pumpStatus),
                style: ElevatedButton.styleFrom(
                  backgroundColor: pumpStatus ? Colors.green : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  pumpStatus ? 'TURN PUMP OFF' : 'TURN PUMP ON',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        _buildSensorCard('Humidity', '$humidity%', Icons.water_drop, Colors.blue),
        _buildSensorCard('Temperature', '${temperature.toStringAsFixed(1)}°C',
            Icons.thermostat, Colors.orange),
        _buildSensorCard('Soil Moisture', '$soilMoisture%', Icons.grass, Colors.brown),
        _buildSensorCard('Water Level', '$waterLevel%', Icons.invert_colors, Colors.lightBlue),
      ],
    );
  }

  Widget _buildSensorCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorGraphs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sensor Data History',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildSensorGraph('Humidity (%)', [65, 68, 62, 70, 65, 63]),
        _buildSensorGraph('Temperature (°C)', [26, 28, 27, 29, 28, 27]),
        _buildSensorGraph('Soil Moisture (%)', [45, 42, 40, 43, 41, 42]),
        _buildSensorGraph('Water Level (%)', [80, 78, 75, 72, 74, 75]),
      ],
    );
  }

  Widget _buildSensorGraph(String title, List<double> data) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(isVisible: false),
                series: <LineSeries<double, int>>[
                  LineSeries<double, int>(
                    dataSource: data,
                    xValueMapper: (double value, int index) => index,
                    yValueMapper: (double value, _) => value,
                    color: Colors.green,
                    width: 3,
                    markerSettings: const MarkerSettings(isVisible: true),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeveloperProfilePage extends StatelessWidget {
  const DeveloperProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.green[100],
              child: const Icon(Icons.person, size: 60, color: Colors.green),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Flutter Developer',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 30),

          _buildProfileItem(Icons.school, 'Education', 'Computer Science B.Sc.'),
          _buildProfileItem(Icons.code, 'Skills', 'Flutter, Firebase, IoT'),
          _buildProfileItem(Icons.location_city, 'University', 'Green Valley University'),
          _buildProfileItem(Icons.calendar_today, 'Age', '24 years'),
          _buildProfileItem(Icons.email, 'Contact', 'john.doe@example.com'),

          const SizedBox(height: 30),
          const Text(
            'About Me',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Passionate about creating IoT solutions with Flutter. Developed this app to help manage smart agriculture systems efficiently.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.green[800]),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need Help?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Contact our support team or follow the instructions below',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 30),

          _buildHelpCard(
            Icons.phone,
            'Contact Support',
            'Call our 24/7 support line',
            '+1 (555) 123-4567',
          ),
          _buildHelpCard(
            Icons.email,
            'Email Us',
            'Send us your questions',
            'support@agrotech.com',
          ),
          _buildHelpCard(
            Icons.chat,
            'Live Chat',
            'Chat with our support agents',
            'Available 9AM - 5PM',
          ),

          const SizedBox(height: 30),
          const Text(
            'Mobile App Guide',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildStepItem('1', 'Dashboard shows real-time sensor data'),
          _buildStepItem('2', 'Toggle pump control between auto/manual'),
          _buildStepItem('3', 'View historical data in graph format'),
          _buildStepItem('4', 'Contact support if issues persist'),

          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('FAQs & Troubleshooting'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard(IconData icon, String title, String subtitle, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.green[800]),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 5),
                  Text(value, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.green[800],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(number, style: const TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}