// file: coffee_assemblage_screen.dart

import 'package:flutter/material.dart';

class CoffeeAssemblageScreen extends StatefulWidget {
  // NEW: Add a final variable to hold the total amount.
  final int totalAmount;

  // NEW: Update the constructor to require the totalAmount.
  const CoffeeAssemblageScreen({super.key, required this.totalAmount});

  @override
  State<CoffeeAssemblageScreen> createState() => _CoffeeAssemblageScreenState();
}

class _CoffeeAssemblageScreenState extends State<CoffeeAssemblageScreen> {
  // State variables to track the user's selections.
  double _coffeeType = 0.5; // Arabica (0) to Robusta (1)
  int _selectedRoasting =
      0; // 0: none, 1: one flame, 2: two flames, 3: three flames
  int _selectedGrinding = 0; // 0: none, 1: whole bean, 2: ground
  int _selectedIce = 0; // 0: none, 1: low, 2: medium, 3: high

  // Helper widget to build the icons for roasting, grinding, and ice.
  Widget _buildIconSelector({
    required int value,
    required int selectedValue,
    required Widget icon,
    required ValueSetter<int> onSelect,
  }) {
    return GestureDetector(
      onTap: () => onSelect(value),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedValue == value
              ? const Color.fromARGB(255, 220, 165, 0)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedValue == value
                ? const Color.fromARGB(255, 220, 165, 0)
                : Colors.grey.shade300,
          ),
        ),
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Coffee lover assemblage',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              // TODO: Implement navigation to the cart screen.
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Select a barista section
                _buildOptionRow(
                  title: 'Select a barista',
                  onTap: () {
                    // TODO: Implement barista selection logic.
                  },
                ),
                const SizedBox(height: 20),

                // Coffee type section with slider
                const Text(
                  'Coffee type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Slider(
                  value: _coffeeType,
                  onChanged: (newValue) {
                    setState(() {
                      _coffeeType = newValue;
                    });
                  },
                  activeColor: const Color.fromARGB(255, 220, 165, 0),
                  inactiveColor: Colors.grey.shade300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Arabica', style: TextStyle(color: Colors.grey)),
                    Text('Robusta', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20),

                // Coffee sort section
                _buildOptionRow(
                  title: 'Coffee sort',
                  onTap: () {
                    // TODO: Implement coffee sort selection logic.
                  },
                ),
                const SizedBox(height: 20),

                // Roasting section with flames
                const Text(
                  'Roasting',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconSelector(
                      value: 1,
                      selectedValue: _selectedRoasting,
                      icon: const Icon(
                        Icons.local_fire_department,
                        color: Color.fromARGB(255, 220, 165, 0),
                      ),
                      onSelect: (value) {
                        setState(() {
                          _selectedRoasting = value;
                        });
                      },
                    ),
                    _buildIconSelector(
                      value: 2,
                      selectedValue: _selectedRoasting,
                      icon: Row(
                        children: const [
                          Icon(
                            Icons.local_fire_department,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                          Icon(
                            Icons.local_fire_department,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                        ],
                      ),
                      onSelect: (value) {
                        setState(() {
                          _selectedRoasting = value;
                        });
                      },
                    ),
                    _buildIconSelector(
                      value: 3,
                      selectedValue: _selectedRoasting,
                      icon: Row(
                        children: const [
                          Icon(
                            Icons.local_fire_department,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                          Icon(
                            Icons.local_fire_department,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                          Icon(
                            Icons.local_fire_department,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                        ],
                      ),
                      onSelect: (value) {
                        setState(() {
                          _selectedRoasting = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Grinding section with coffee beans
                const Text(
                  'Grinding',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconSelector(
                      value: 1,
                      selectedValue: _selectedGrinding,
                      icon: const Icon(
                        Icons.coffee_outlined,
                        color: Color.fromARGB(255, 220, 165, 0),
                      ),
                      onSelect: (value) {
                        setState(() {
                          _selectedGrinding = value;
                        });
                      },
                    ),
                    _buildIconSelector(
                      value: 2,
                      selectedValue: _selectedGrinding,
                      icon: const Icon(
                        Icons.coffee,
                        color: Color.fromARGB(255, 220, 165, 0),
                      ),
                      onSelect: (value) {
                        setState(() {
                          _selectedGrinding = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Milk, Syrup, Additives sections
                _buildSelectableRow(
                  title: 'Milk',
                  onTap: () {
                    // TODO: Implement milk selection.
                  },
                ),
                _buildSelectableRow(
                  title: 'Syrup',
                  onTap: () {
                    // TODO: Implement syrup selection.
                  },
                ),
                _buildOptionRow(
                  title: 'Additives',
                  onTap: () {
                    // TODO: Implement additives selection.
                  },
                ),
                const SizedBox(height: 20),

                // Ice section
                const Text(
                  'Ice',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconSelector(
                      value: 1,
                      selectedValue: _selectedIce,
                      icon: const Icon(
                        Icons.icecream,
                        color: Color.fromARGB(255, 220, 165, 0),
                      ),
                      onSelect: (value) {
                        setState(() {
                          _selectedIce = value;
                        });
                      },
                    ),
                    _buildIconSelector(
                      value: 2,
                      selectedValue: _selectedIce,
                      icon: Row(
                        children: const [
                          Icon(
                            Icons.icecream,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                          Icon(
                            Icons.icecream,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                        ],
                      ),
                      onSelect: (value) {
                        setState(() {
                          _selectedIce = value;
                        });
                      },
                    ),
                    _buildIconSelector(
                      value: 3,
                      selectedValue: _selectedIce,
                      icon: Row(
                        children: const [
                          Icon(
                            Icons.icecream,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                          Icon(
                            Icons.icecream,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                          Icon(
                            Icons.icecream,
                            color: Color.fromARGB(255, 220, 165, 0),
                          ),
                        ],
                      ),
                      onSelect: (value) {
                        setState(() {
                          _selectedIce = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 150), // Space for the bottom bar
              ],
            ),
          ),
          // Bottom section with total amount and next button.
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // NEW: Use the passed-in totalAmount from the constructor.
                      // This makes the value dynamic.
                      Text(
                        'KHR ${widget.totalAmount.toStringAsFixed(0)}', // Using .toStringAsFixed(0) to remove decimal.
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement navigation to checkout.
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 220, 165, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // A helper method for rows that navigate to another screen.
  Widget _buildOptionRow({required String title, required VoidCallback onTap}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.black,
              ),
              onPressed: onTap,
            ),
          ],
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }

  // A helper method for rows that have a "Select" button.
  Widget _buildSelectableRow({
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Select',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
