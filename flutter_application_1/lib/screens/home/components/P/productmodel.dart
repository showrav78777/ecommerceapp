// // class Product {
// //   final String id;
// //   final String title;
// //   final String description;
// //   final double price;
// //   final List<String> photoUrls; // List of photo URLs
// //  // final bool isPopular;

// //   Product({
// //     required this.id,
// //     required this.title,
// //     required this.description,
// //     required this.price,
// //     required this.photoUrls,
// //    // required this.isPopular,
// //   });

// //   factory Product.fromMap(Map<String, dynamic> map) {
// //     final photosData = (map['photos'] as Map<String, dynamic>?) ?? {};
// //     final List<String> photoUrls = photosData.values
// //         .map<String>((photo) => photo['url'] as String)
// //         .toList();
// //     return Product(
// //       id: map['id'] ?? '', // Make sure the 'id' field is correctly mapped
// //       title: map['title'] ?? '',
// //       description: map['description'] ?? '',
// //       price: (map['price'] ?? 0).toDouble(),
// //       photoUrls: photoUrls,
// //       // isPopular: map['isPopular'] ?? false,
// //     );
// //   }
// // }

// class Product {
//   final String id;
//   final String title;
//   final String description;
//   final double price;
//   final List<String> photoUrls;

//   Product({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.photoUrls,
//   });

//   factory Product.fromMap(Map<String, dynamic> map) {
//     final photosData = (map['photos'] as Map<String, dynamic>?) ?? {};
//     final List<String> photoUrls = photosData.values
//         .map<String>((photo) => photo['url'] as String)
//         .toList();
//     return Product(
//       id: map['id'] ?? '', // Ensure ID is mapped correctly
//       title: map['title'] ?? '',
//       description: map['description'] ?? '',
//       price: (map['price'] ?? 0).toDouble(),
//       photoUrls: photoUrls,
//     );
//   }
// }

// class ProductModel {
//   final String id;
//   final String title; // Change 'name' to 'title' to match Firestore document
//   final String category;
//   final String description;
//   final double price;
//   final List<String> photoUrls;

//   ProductModel({
//     required this.id,
//     required this.title, // Change 'name' to 'title' to match Firestore document
//     required this.category,
//     required this.description,
//     required this.price,
//     required this.photoUrls,
//   });

//   factory ProductModel.fromMap(Map<String, dynamic> map) {
//     final photosData = (map['photos'] as Map<String,dynamic>?)??{};
//     final List<String> photoUrls=photosData.values
//     .map<String>((photo) => photo['url'] as String)
//     .toList();
//     return ProductModel(
//       id: map['id'] as String? ?? '',
//       title: map['name'] as String? ?? '', // Change 'name' to 'title'
//       category: map['category'] as String? ?? '',
//       description: map['description'] as String? ?? '',
//       price: (map['price'] as num?)?.toDouble() ?? 0.0,
//       photoUrls: photoUrls,
//     );
//   }
// }

class ProductModel {
  final String id;
  final String title;
  final String category;
  final double price;
  final String description;
  final String imageUrl; // Add imageUrl field

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
     required this.description,
    required this.price,
    required this.imageUrl, 
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['name'] ?? '',
      category: map['category'] ?? '',
       description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      imageUrl: map['imageUrl'] ?? '', // Initialize imageUrl field
    );
  }
}
