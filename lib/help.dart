import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FAQ Section
            _buildSectionHeader(
              context,
              'Frequently Asked Questions',
              Icons.help_outline,
            ),
            SizedBox(height: 12),
            _buildFAQItem(
              context,
              'How to connect to the system?',
              'Go to Settings > Device Connection and follow the pairing instructions.',
            ),
            _buildFAQItem(
              context,
              'How to control the irrigation pump?',
              'Navigate to Dashboard and use the pump switch. The system will automatically water when soil moisture is low.',
            ),
            _buildFAQItem(
              context,
              'How to read sensor data?',
              'All sensor data is displayed on the Dashboard with real-time updates every 5 seconds.',
            ),
            SizedBox(height: 24),

            // Contact Support Section
            _buildSectionHeader(
              context,
              'Contact Support',
              Icons.contact_support,
            ),
            SizedBox(height: 12),
            _buildContactOption(
              context,
              FontAwesomeIcons.envelope,
              'Email Us',
              'support@smartfarm.com',
              Colors.red[400]!,
                  () => _launchEmail(),
            ),
            _buildContactOption(
              context,
              FontAwesomeIcons.phone,
              'Call Us',
              '+6012-345 6789',
              Colors.green[600]!,
                  () => _launchPhoneCall(),
            ),
            _buildContactOption(
              context,
              FontAwesomeIcons.whatsapp,
              'WhatsApp',
              '+6012-345 6789',
              Colors.green[500]!,
                  () => _launchWhatsApp(),
            ),
            SizedBox(height: 24),

            // Video Tutorials Section
            _buildSectionHeader(
              context,
              'Video Tutorials',
              Icons.video_library,
            ),
            SizedBox(height: 12),
            _buildVideoCard(
              context,
              'Getting Started',
              'Learn how to set up your Smart Farming system',
              'https://youtube.com/shorts/aOhXgG2agHk?feature=share', // Ganti dengan ID YouTube sebenar
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk melancarkan email - DIPERBAIKI
  _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@smartfarm.com',
      queryParameters: {
        'subject': 'SmartFarm Support Request',
        'body': 'Hello, I need help with...',
      },
    );

    final String url = emailLaunchUri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch email';
    }
  }

// Fungsi untuk melancarkan panggilan telefon - DIPERBAIKI
  _launchPhoneCall() async {
    const String url = 'tel:+60123456789'; // Format internasional tanpa spasi
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch phone call';
    }
  }

// Fungsi untuk melancarkan WhatsApp - SUDAH BERFUNGSI
  _launchWhatsApp() async {
    const String url = 'https://wa.me/60123456789?text=Hello%20SmartFarm%20support,%20I%20need%20help%20with...';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 28, color: Colors.green[800]),
        SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.green[800],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: Text(
              answer,
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(
      BuildContext context,
      IconData icon,
      String title,
      String value,
      Color color,
      VoidCallback onTap,
      ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
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
          style: GoogleFonts.poppins(),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildVideoCard(
      BuildContext context,
      String title,
      String description,
      String youtubeUrl,
      ) {
    final videoId = YoutubePlayer.convertUrlToId(youtubeUrl) ?? '';

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              color: Colors.grey[200],
              height: 200,
              child: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                ),
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.green[800],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text(title),
                          ),
                          body: Center(
                            child: YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: videoId,
                                flags: YoutubePlayerFlags(
                                  autoPlay: true,
                                  mute: false,
                                ),
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.green[800],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Watch Tutorial',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}