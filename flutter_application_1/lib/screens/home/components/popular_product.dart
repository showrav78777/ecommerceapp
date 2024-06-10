import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'P/productmodel.dart';
import 'productdetails.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  Future<List<ProductModel>> queryAllProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      if (querySnapshot.docs.isEmpty) {
        print('No products found in the collection.');
        return [];
      }

      List<ProductModel> products = [];
      for (DocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
        if (data == null) {
          print('Product document not found for ID: ${document.id}');
          continue;
        }
        print('Fetched product data for ID: ${document.id} - Data: $data');
        products.add(ProductModel.fromMap({
          ...data,
          'id': document.id,
          'url': data['url'],
        }));
      }
      return products;
    } catch (error) {
      print('Error fetching products: $error');
      return [];
    }
  }

  Future<List<String>> queryProductPhotos(String productId) async {
    try {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();

      if (!productSnapshot.exists) {
        print('Product document not found for ID: $productId');
        return [];
      }

      Map<String, dynamic>? data =
          productSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('url')) {
        dynamic photoUrlsData = data['url'];

        List<String> photoUrls = [];
        if (photoUrlsData is String) {
          photoUrls =
              photoUrlsData.split(',').map((url) => url.trim()).toList();
        } else if (photoUrlsData is List<dynamic>) {
          photoUrls = List<String>.from(photoUrlsData);
        }

        return photoUrls;
      } else {
        print('No photoUrls found for product with ID: $productId');
        return [];
      }
    } catch (error, stackTrace) {
      print('Error fetching product photos for product ID $productId: $error');
      print('StackTrace: $stackTrace');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Products'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: queryAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching products. Please try again later.'),
            );
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const Center(
              child: Text('No products available.'),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to product detail screen
                  navigateToProductDetail(context, product);
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<List<String>>(
                        future: queryProductPhotos(product.id),
                        builder: (context, photoSnapshot) {
                          if (photoSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (photoSnapshot.hasError) {
                            return const Text('Error fetching product photos.');
                          }
                          final photoUrls = photoSnapshot.data ?? [];
                          if (photoUrls.isNotEmpty) {
                            return CachedNetworkImage(
                              imageUrl: photoUrls[0], // Display the first image
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Container(
                                width: double.infinity,
                                height: 150,
                                color: Colors.grey,
                                child: const Icon(Icons.error),
                              ),
                            );
                          } else {
                            return Container(
                              height: 150,
                              color: Colors.grey,
                              child: const Center(child: Text('No image')),
                            );
                          }
                        },
                      ),
                      ListTile(
                        // title: Text(
                        //   product.title,
                        //   style: const TextStyle(
                        //     fontSize: 16.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ${product.title}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Price: Tk.${product.price.toString()}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void navigateToProductDetail(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(productModel: product),
      ),
    );
  }
}
