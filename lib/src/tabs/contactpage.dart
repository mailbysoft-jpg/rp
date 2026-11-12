import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  void openMap() {
    launchUrl(
      Uri.parse('https://maps.app.goo.gl/ncNELf9v46EytV6E7'),
      mode: LaunchMode.externalApplication,
    );
  }

  void openWhatsApp(String phone) {
    launchUrl(
      Uri.parse('https://wa.me/91$phone'),
      mode: LaunchMode.externalApplication,
    );
  }

  // ----------------------------
  // OPEN PHONE
  // ----------------------------
  void callNumber(String phone) {
    launchUrl(Uri.parse('tel:$phone'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          const Column(
            children: [
              Icon(
                Icons.storefront_outlined,
                size: 42,
                color: Color(0xFFB78628),
              ),

              SizedBox(height: 8),

              Text(
                'Contact Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 4),

              Text(
                'Connect with our division representatives',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFFB78628),
                      ),

                      SizedBox(width: 8),

                      Text(
                        'Visit Our Store',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // MAP BUTTON
                  InkWell(
                    onTap: openMap,

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F7),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(Icons.map_outlined, color: Color(0xFFB78628)),

                          SizedBox(width: 8),

                          Text(
                            'Open Google Maps',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Rp Silver House',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 4),

                  const Text('Gangi Ram Mandir, Main Road'),

                  const Text(
                    'Padrauna, Kushinagar',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          divisionCard(
            title: 'Owner',
            owner: 'Rishi Pratap Soni',
            color: const Color(0xFF2B0008),
            icon: Icons.person_outline,

            phones: ['9792447706'],
          ),
          const SizedBox(height: 16),
          divisionCard(
            title: 'Silver Division',
            owner: 'Sumit Soni',
            color: const Color(0xFF7C858F),
            icon: Icons.diamond_outlined,

            phones: ['9792447713', '9670849674'],
          ),
          const SizedBox(height: 16),

          // ----------------------------
          // GOLD DIVISION
          // ----------------------------
          divisionCard(
            title: 'Gold Division',
            owner: 'Prem Soni',
            color: const Color(0xFFB78628),
            icon: Icons.military_tech_outlined,

            phones: ['9792447714', '9695283322'],
          ),
        ],
      ),
    );
  }

  // ==================================================
  // DIVISION CARD
  // ==================================================

  Widget divisionCard({
    required String title,
    required String owner,
    required Color color,
    required IconData icon,
    required List<String> phones,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  child: Icon(icon, color: Colors.white),
                ),

                const SizedBox(width: 12),

                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // OWNER
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.12),
                  child: Text(
                    owner[0].toUpperCase(),
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    owner,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PHONE NUMBERS
          for (String phone in phones) phoneRow(phone),
        ],
      ),
    );
  }
  // ==================================================
  // PHONE ROW
  // ==================================================

  Widget phoneRow(String phone) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E5EA))),
      ),

      child: Row(
        children: [
          const Icon(Icons.phone_outlined, color: Colors.grey),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              phone,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          // WHATSAPP
          IconButton(
            onPressed: () {
              openWhatsApp(phone);
            },

            icon: const Icon(Icons.chat_outlined, color: Color(0xFF25D366)),
          ),

          // CALL
          IconButton(
            onPressed: () {
              callNumber(phone);
            },

            icon: const Icon(Icons.call_outlined, color: Color(0xFF007AFF)),
          ),
        ],
      ),
    );
  }
}
