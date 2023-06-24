import 'package:flutter/material.dart';

class LandCard extends StatelessWidget {
  final String location;
  final String owner;
  final String totalLand;
  final String pricePerUnit;
  final bool isBuying;
  final void Function()? onBuy;

  const LandCard({
    super.key,
    required this.location,
    required this.owner,
    required this.totalLand,
    required this.pricePerUnit,
    required this.onBuy,
    this.isBuying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Set the card elevation (shadow)
      margin: const EdgeInsets.all(8), // Set the card margin
      child: Padding(
        padding: const EdgeInsets.all(16), // Set the padding inside the card
        child: isBuying
            ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Buying...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ), // Add some space between title and author
                  Text(
                    'By $owner',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Total Land: $totalLand',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Price Per Unit: $pricePerUnit MATIC',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: onBuy,
                    child: const Text("Buy Land"),
                  ),
                ],
              ),
      ),
    );
  }
}
