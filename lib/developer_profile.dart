import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  // Profile Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Tambahkan ini
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.green[800]!,
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage('assets/developer.jpg'),
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding( // Tambahkan Padding untuk text
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Text(
                                  'Farish Yamer bin Fauzi',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800],
                                  ),
                                  textAlign: TextAlign.center, // Tambahkan textAlign
                                ),
                                Text(
                                  'Flutter & IoT Developer',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center, // Tambahkan textAlign
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding( // Tambahkan Padding untuk Divider
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(),
                          ),
                          SizedBox(height: 16),

                          // Personal Info dengan Padding
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                _buildInfoRow(Icons.school, '4A', 'Class'),
                                _buildInfoRow(Icons.cake, '20 Years', 'Age'),
                                _buildInfoRow(
                                  Icons.workspace_premium,
                                  'Diploma in \nElectronic Engineering (IoT)',
                                  'Education',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // About Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.green[800]),
                              SizedBox(width: 8),
                              Text(
                                'About Developer',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            'A passionate mobile developer with 3 years of experience in Flutter development and IoT systems. '
                                'Specialized in building smart farming solutions that integrate hardware sensors with mobile applications '
                                'for real-time monitoring and control.\n\n'
                                'Developed multiple smart agriculture projects including automated irrigation systems, crop monitoring platforms, '
                                'and livestock tracking solutions. Strong background in Firebase, REST APIs, and embedded systems programming.',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Skills Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.code, color: Colors.green[800]),
                              SizedBox(width: 8),
                              Text(
                                'Technical Skills',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildSkillChip('Flutter', Colors.green[800]!),
                              _buildSkillChip('Dart', Colors.blue[800]!),
                              _buildSkillChip('Firebase', Colors.orange[800]!),
                              _buildSkillChip('IoT', Colors.purple[800]!),
                              _buildSkillChip('Embedded Systems', Colors.red[800]!),
                              _buildSkillChip('REST APIs', Colors.teal[800]!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Contact Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.connect_without_contact, color: Colors.green[800]),
                              SizedBox(width: 8),
                              Text(
                                'Connect With Me',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          _buildContactButton(
                            context,
                            FontAwesomeIcons.github,
                            'GitHub',
                            'github.com/farishyamer',
                            Colors.black,
                                () => _launchURL('https://github.com/farishyamer'),
                          ),
                          _buildContactButton(
                            context,
                            FontAwesomeIcons.linkedin,
                            'LinkedIn',
                            'linkedin.com/in/farishyamer',
                            Colors.blue[700]!,
                                () => _launchURL('https://linkedin.com/in/farishyamer'),
                          ),
                          _buildContactButton(
                            context,
                            FontAwesomeIcons.envelope,
                            'Email',
                            'farishyamer@smartfarm.com',
                            Colors.red[600]!,
                                () => _launchEmail('farishyamer@smartfarm.com'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk membuka URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Fungsi untuk membuka email
  Future<void> _launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello from SmartFarm App',
    );

    final String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch email';
    }
  }

  Widget _buildInfoRow(IconData icon, String value, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.green[800], size: 20),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String text, Color color) {
    return Chip(
      label: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildContactButton(
      BuildContext context,
      IconData icon,
      String title,
      String value,
      Color color,
      VoidCallback onTap,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: FaIcon(icon, color: color),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}