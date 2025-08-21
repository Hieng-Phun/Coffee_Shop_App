// home_menu_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing/screen/home/oder_screen.dart';
import 'package:testing/screen/home/profile_screen.dart';

// This is the main screen widget for the coffee menu.
// It is now a StatefulWidget to manage the language selection state.
class HomeMenuScreen extends StatefulWidget {
  // Add a final variable to store the selected location.
  final String? selectedLocation;

  const HomeMenuScreen({
    super.key,
    this.selectedLocation, // Now accepting the selected location.
  });

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
  // State variable to hold the currently selected language.
  // This is a simple representation; for a real app, you would use a localization package.
  String _selectedLanguage = 'EN';

  // Function to show the language selection dialog.
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Change Language'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLanguageOption('EN', 'English'),
                _buildLanguageOption('KM', 'Khmer'),
                _buildLanguageOption('ES', 'Spanish'),
              ],
            ),
          ),
        );
      },
    );
  }

  // A helper method to build a single language option tile.
  Widget _buildLanguageOption(String code, String name) {
    return ListTile(
      title: Text(name),
      trailing: _selectedLanguage == code
          ? const Icon(Icons.check, color: Color.fromARGB(255, 220, 165, 0))
          : null,
      onTap: () {
        setState(() {
          _selectedLanguage = code;
        });
        Navigator.pop(context); // Close the dialog.
        // In a real application, you would change the app's locale here.
        // For this example, we'll just print to the console.
        print('Language changed to: $name');
      },
    );
  }

  // A helper method to create the top header widget.
  Widget _buildHeader(BuildContext context, String displayName) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome!',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          // Row of icons for language, cart, and profile.
          Row(
            children: [
              // Language icon button.
              IconButton(
                icon: const Icon(Icons.language, size: 30),
                onPressed: _showLanguageDialog,
              ),
              const SizedBox(width: 10),
              // Cart icon button.
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 30),
                onPressed: () {
                  // Handle cart button press.
                },
              ),
              const SizedBox(width: 10),
              // Profile icon button.
              IconButton(
                icon: const Icon(Icons.person_outline, size: 30),
                onPressed: () {
                  // Navigate to the ProfileScreen and pass the selected location.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        selectedLocation: widget.selectedLocation,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    // Get the current user from Firebase Auth.
    final user = FirebaseAuth.instance.currentUser;
    // Use the user's email or a default name if not available.
    final displayName = user?.email?.split('@')[0] ?? 'User';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top header with user greeting, cart, and profile icon.
            _buildHeader(context, displayName),
            // The main content area with the yellow background.
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 220, 165, 0),
                // A warm yellow color.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // "Select your coffee" title.
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Select your coffee',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // The grid of coffee items.
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          children: [
                            CoffeeItem(
                              imagePath: 'assets/images/americano.png',
                              name: 'Americano',
                              onTap: () {
                                // Navigate to the OrderScreen and pass the selected coffee name and image path.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderScreen(
                                      coffeeName: 'Americano',
                                      imagePath: 'assets/images/americano.png',
                                    ),
                                  ),
                                );
                              },
                            ),
                            CoffeeItem(
                              imagePath: 'assets/images/cappuccino.png',
                              name: 'Cappuccino',
                              onTap: () {
                                // Navigate to the OrderScreen and pass the selected coffee name and image path.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderScreen(
                                      coffeeName: 'Cappuccino',
                                      imagePath: 'assets/images/cappuccino.png',
                                    ),
                                  ),
                                );
                              },
                            ),
                            CoffeeItem(
                              imagePath: 'assets/images/latte.png',
                              name: 'Latte',
                              onTap: () {
                                // Navigate to the OrderScreen and pass the selected coffee name and image path.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderScreen(
                                      coffeeName: 'Latte',
                                      imagePath: 'assets/images/latte.png',
                                    ),
                                  ),
                                );
                              },
                            ),
                            CoffeeItem(
                              imagePath: 'assets/images/flat_white.png',
                              name: 'Flat White',
                              onTap: () {
                                // Navigate to the OrderScreen and pass the selected coffee name and image path.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderScreen(
                                      coffeeName: 'Flat White',
                                      imagePath: 'assets/images/flat_white.png',
                                    ),
                                  ),
                                );
                              },
                            ),
                            CoffeeItem(
                              imagePath: 'assets/images/raf.png',
                              name: 'Raf',
                              onTap: () {
                                // Navigate to the OrderScreen and pass the selected coffee name and image path.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderScreen(
                                      coffeeName: 'Raf',
                                      imagePath: 'assets/images/raf.png',
                                    ),
                                  ),
                                );
                              },
                            ),
                            CoffeeItem(
                              imagePath: 'assets/images/espresso.png',
                              name: 'Espresso',
                              onTap: () {
                                // Navigate to the OrderScreen and pass the selected coffee name and image path.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderScreen(
                                      coffeeName: 'Espresso',
                                      imagePath: 'assets/images/espresso.png',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Bottom navigation bar.
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }
}

// A reusable widget for the grid items on the coffee menu.
class CoffeeItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final VoidCallback onTap; // Add an onTap callback.

  const CoffeeItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap, // Use the onTap callback here.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image for the coffee item.
            // NOTE: You will need to add these images to your assets folder
            // and update your pubspec.yaml file.
            Image.asset(
              imagePath,
              height: 100, // Adjust the size as needed.
            ),
            const SizedBox(height: 10),
            // Name of the coffee item.
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
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
        color: isSelected ? Colors.yellow[700] : Colors.transparent,
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
