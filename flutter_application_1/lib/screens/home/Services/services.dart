import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            ServiceButton(
              title: 'Repair Products',
              imageAsset: 'assets/images/repair.jpg', // Replace with your image asset path
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServiceDetailPage(
                      title: 'Repair Products',
                      imageUrl: 'assets/images/repair.jpg',
                      serviceType: 'Repair Service',
                      description: 'We offer expert repair services for all your products. Our skilled technicians can fix a wide range of issues and ensure your items are as good as new.',
                    ),
                  ),
                );
              },
            ),
            ServiceButton(
              title: 'Cleaning Services',
              imageAsset: 'assets/images/cleaningpic.jpeg', // Replace with your image asset path
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServiceDetailPage(
                      title: 'Cleaning Services',
                      imageUrl: 'assets/images/cleaningpic.jpeg',
                      serviceType: 'Cleaning Service',
                      description: 'Our professional cleaning services cover residential and commercial properties. We use eco-friendly products to leave your space spotless and healthy.',
                    ),
                  ),
                );
              },
            ),
            ServiceButton(
              title: 'Home Maintenance',
              imageAsset: 'assets/images/maintenance.jpg', // Replace with your image asset path
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServiceDetailPage(
                      title: 'Home Maintenance',
                      imageUrl: 'assets/images/maintenance.jpg',
                      serviceType: 'Maintenance Service',
                      description: 'Our home maintenance services include plumbing, electrical work, and general repairs. We help keep your home in top condition with regular upkeep and prompt fixes.',
                    ),
                  ),
                );
              },
            ),
            ServiceButton(
              title: 'Consultation Services',
              imageAsset: 'assets/images/consultation.jpg', // Replace with your image asset path
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServiceDetailPage(
                      title: 'Consultation Services',
                      imageUrl: 'assets/images/consultation.jpg',
                      serviceType: 'Consultation Service',
                      description: 'Our consultation services provide expert advice in various fields, including finance, health, and technology. Get the guidance you need to make informed decisions.',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onPressed;

  const ServiceButton({
    required this.title,
    required this.imageAsset,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity, // Expand button to full width
            height: 150, // Set the height of the button
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero, // Remove default button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5, // Add some elevation for a raised effect
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imageAsset,
                        fit: BoxFit.cover, // Fit image within the box
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10), // Add space between image and title
          Text(
            title,
            textAlign: TextAlign.center, // Center the title text
            style: TextStyle(
              fontSize: 18, // Adjust font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl; // Add imageUrl for the service image
  final String serviceType; // Add serviceType
  final String description; // Add description

  const ServiceDetailPage({
    required this.title,
    required this.imageUrl,
    required this.serviceType,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 200, // Set height for the image
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Service Type: $serviceType',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Book service logic
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  alignment: Alignment.center,
                  child: Text(
                    'Book $title',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
