import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'P/productmodel.dart';
import 'cart.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel productModel;
  final int initialQuantity;

  const ProductDetails({
    required this.productModel,
    this.initialQuantity = 1,
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  Future<List<String>> queryProductPhotos(String productId) async {
    try {
      DocumentSnapshot productSnapshot =
          await FirebaseFirestore.instance.collection('Products').doc(productId).get();

      if (productSnapshot.exists) {
        Map<String, dynamic>? data = productSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('url')) {
          dynamic photoUrlsData = data['url'];

          List<String> photoUrls = [];
          if (photoUrlsData is String) {
            photoUrls = photoUrlsData.split(',').map((url) => url.trim()).toList();
          } else if (photoUrlsData is List<dynamic>) {
            photoUrls = List<String>.from(photoUrlsData);
          }

          return photoUrls;
        } else {
          print('No photoUrls found for product with ID: $productId');
          return [];
        }
      } else {
        print('Product document not found for ID: $productId');
        return [];
      }
    } catch (error, stackTrace) {
      print('Error fetching product photos for product ID $productId: $error');
      print('StackTrace: $stackTrace');
      return [];
    }
  }

  double calculateTotalPrice() {
    double basePrice = widget.productModel.price.toDouble();
    double totalPrice = basePrice * quantity;
    return totalPrice;
  }

  Future<void> addToCart(ProductModel product, int quantity) async {
    try {
      await FirebaseFirestore.instance.collection('Cart').add({
        'productId': product.id,
        'title': product.title,
        'price': product.price,
        'quantity': quantity,
        'totalPrice': product.price * quantity,
        'imageUrl': product.imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.title} added to cart')),
      );
    } catch (error) {
      print('Error adding product to cart: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add product to cart')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FutureBuilder<List<String>>(
              future: queryProductPhotos(widget.productModel.id),
              builder: (context, photoSnapshot) {
                if (photoSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (photoSnapshot.hasError) {
                  print('Error fetching product photos: ${photoSnapshot.error}');
                  return const Text('Error fetching product photos.');
                }
                final photoUrls = photoSnapshot.data ?? [];
                return photoUrls.isNotEmpty
                    ? Image.network(photoUrls.first, fit: BoxFit.cover)
                    : const Placeholder();
              },
            ),
          ),
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    Text(
                      widget.productModel.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const SizedBox(height: 16.0),
                    Text(
                      widget.productModel.description ?? 'No description available',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tk.${widget.productModel.price.toString()} /per unit',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      "PRODUCT DETAILS",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.productModel.description ?? 'No additional details available.',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        const Text(
                          "Category:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          ' ${widget.productModel.category}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'For $quantity unit(s): Tk.${calculateTotalPrice().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        const Text(
                          "Quantity:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        DropdownButton<int>(
                          value: quantity,
                          onChanged: (int? newValue) {
                            setState(() {
                              quantity = newValue ?? 1;
                            });
                          },
                          items: List.generate(10, (index) => index + 1)
                              .map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            addToCart(widget.productModel, quantity);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            double totalPrice = calculateTotalPrice();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
