// file: order_screen.dart

import 'package:flutter/material.dart';
import 'package:testing/screen/home/coffee_assemblage_screen.dart';

class OrderScreen extends StatefulWidget {
  final String coffeeName;
  final String imagePath; // Add this parameter to accept the image path

  const OrderScreen({
    super.key,
    required this.coffeeName,
    required this.imagePath, // Make the image path a required parameter
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // State variables for managing selections and quantity
  int _quantity = 1;
  String? _selectedRistretto;
  String? _selectedOrderType;
  int? _selectedVolume;
  bool _isPrepareTimeEnabled = false;

  // Define the base price of the coffee
  final int _basePrice = 3000;
  int _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalAmount();
  }

  // Method to calculate the total amount
  void _calculateTotalAmount() {
    setState(() {
      _totalAmount = _quantity * _basePrice;
    });
  }

  // A list of available volumes
  final List<int> _volumes = [250, 350, 450];

  // Helper method to build a selection button
  Widget _buildSelectionButton(
    String text,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 220, 165, 0)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Helper method to build an icon-based selection button
  Widget _buildIconSelectionButton(
    IconData icon,
    String text,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 220, 165, 0)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: isSelected
              ? null // No shadow when selected to create a sunken effect
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a volume selection button
  Widget _buildVolumeButton(int volume, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 220, 165, 0)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_drink_outlined,
              color: isSelected ? Colors.white : Colors.grey[400],
              size: 32,
            ),
            const SizedBox(height: 4),
            Text(
              '$volume',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Order',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coffee Image and Quantity
              Center(
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    // Display the selected coffee image here.
                    child: Image.asset(
                      widget.imagePath,
                      height: 200,
                      fit: BoxFit.cover, // Adjust the size as needed.
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.coffeeName, // Use the dynamic coffeeName here
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_quantity > 1) {
                                _quantity--;
                                _calculateTotalAmount();
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity++;
                              _calculateTotalAmount();
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.grey, height: 40),

              // Ristretto section
              const Text(
                'Ristretto',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildSelectionButton('One', _selectedRistretto == 'One', () {
                    setState(() {
                      _selectedRistretto = 'One';
                    });
                  }),
                  const SizedBox(width: 12),
                  _buildSelectionButton('Two', _selectedRistretto == 'Two', () {
                    setState(() {
                      _selectedRistretto = 'Two';
                    });
                  }),
                ],
              ),
              const Divider(color: Colors.grey, height: 40),

              // Onsite / Takeaway section
              const Text(
                'Onsite / Takeaway',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildIconSelectionButton(
                    Icons.local_cafe_outlined,
                    'Onsite',
                    _selectedOrderType == 'Onsite',
                    () {
                      setState(() {
                        _selectedOrderType = 'Onsite';
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildIconSelectionButton(
                    Icons.local_shipping_outlined,
                    'Takeaway',
                    _selectedOrderType == 'Takeaway',
                    () {
                      setState(() {
                        _selectedOrderType = 'Takeaway';
                      });
                    },
                  ),
                ],
              ),
              const Divider(color: Colors.grey, height: 40),

              // Volume section
              const Text(
                'Volume, ml',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _volumes.map((volume) {
                  return _buildVolumeButton(
                    volume,
                    _selectedVolume == volume,
                    () {
                      setState(() {
                        _selectedVolume = volume;
                      });
                    },
                  );
                }).toList(),
              ),
              const Divider(color: Colors.grey, height: 40),

              // Prepare time section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Prepare by a certain time today?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _isPrepareTimeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isPrepareTimeEnabled = value;
                      });
                    },
                    activeColor: const Color.fromARGB(255, 220, 165, 0),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_isPrepareTimeEnabled)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '18 : 10', // Placeholder for time
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              // "Coffee lover assemblage" button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to the coffee assemblage screen and pass the total amount
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CoffeeAssemblageScreen(totalAmount: _totalAmount),
                      ),
                    );
                  },
                  icon: const Icon(Icons.list, color: Colors.white),
                  label: const Text(
                    'Coffee lover assemblage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6A238),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    elevation: 5,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Total Amount and Next Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'KHR $_totalAmount', // Use the calculated total amount here
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
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 220, 165, 0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
