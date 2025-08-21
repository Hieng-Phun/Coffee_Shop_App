// file: profile_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing/screen/auth/signin_screen.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import the qr_flutter package// Import url_launcher for opening links

class ProfileScreen extends StatelessWidget {
  // A final variable to receive the selected location from the previous screen.
  final String? selectedLocation;

  // The constructor now accepts the selectedLocation.
  const ProfileScreen({super.key, this.selectedLocation});

  // A helper method to build the profile info tile.
  Widget _buildProfileInfoTile(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromARGB(
                255,
                220,
                165,
                0,
              ), // Yellow background
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.edit, color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  // A helper method to create the bottom navigation bar widget.
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomBarIcon(icon: Icons.store, isSelected: true),
          _BottomBarIcon(icon: Icons.card_giftcard),
          _BottomBarIcon(icon: Icons.receipt),
        ],
      ),
    );
  }

  // Function to handle Firebase sign-out.
  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Use pushReplacement to prevent the user from going back to the previous screen.
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'N/A';
    final displayName = user?.displayName ?? 'User';

    // The address will display the selected location, or a default message if none is selected.
    final userAddress = selectedLocation ?? 'No location selected';

    // Create the Google Maps URL for the QR code data.
    final qrData =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(userAddress)}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Use SingleChildScrollView to prevent overflow on small screens.
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Display username.
            _buildProfileInfoTile(context, Icons.person, 'Name', displayName),
            // Display phone number (placeholder).
            _buildProfileInfoTile(
              context,
              Icons.phone,
              'Phone number',
              '+855 123456789', // Placeholder number
            ),
            // Display email.
            _buildProfileInfoTile(context, Icons.email, 'Email', email),
            // Display address, which now uses the passed location.
            _buildProfileInfoTile(
              context,
              Icons.location_on,
              'Magic Coffee store address',
              userAddress,
            ),
            const SizedBox(height: 40),
            // QR Code Section
            Center(
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 250.0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            // Log out button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _signOut(context),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade800, // Yellow background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    elevation: 5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ), // Add some padding at the bottom of the scrollable content.
          ],
        ),
      ),
      // Move the bottom navigation bar to the Scaffold's bottomNavigationBar property.
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}

// A reusable widget for the bottom navigation icons.
class _BottomBarIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const _BottomBarIcon({required this.icon, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color.fromARGB(255, 220, 165, 0)
            : Colors.transparent, // Use the app's primary color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.grey,
        size: 30,
      ),
    );
  }
}
