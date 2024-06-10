import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<List<Map<String, dynamic>>> getCartItems() async {
    try {
      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection('Cart').get();

      List<Map<String, dynamic>> cartItems = cartSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;  // Store document ID to use it for deletion
        return data;
      }).toList();

      return cartItems;
    } catch (error) {
      print('Error fetching cart items: $error');
      return [];
    }
  }

  double calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item['totalPrice'];
    }
    return totalPrice;
  }

  Future<void> buyNow() async {
    try {
      // Show a confirmation dialog
      bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Purchase'),
          content: const Text('Do you want to proceed with the payment?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        ),
      );

      if (confirmed != true) {
        return; // Exit if the user cancels
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proceeding to payment...')),
      );

      // Clear the cart after purchase
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance.collection('Cart').get();

      for (var doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }

      // Navigate back to the main screen or show a confirmation message
      Navigator.of(context).pop();
    } catch (error) {
      print('Error during purchase: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to complete purchase')),
      );
    }
  }
  Future<void> removeItem(String id) async {
    try {
      await FirebaseFirestore.instance.collection('Cart').doc(id).delete();
      setState(() {});  // Refresh the UI after deleting the item
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item removed from cart')),
      );
    } catch (error) {
      print('Error removing item: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching cart items.'));
          }
          final cartItems = snapshot.data ?? [];
          return cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return ListTile(
                           
                            title: Text(item['title']),
                            subtitle: Text(
                                'Quantity: ${item['quantity']} | Total: Tk.${item['totalPrice'].toStringAsFixed(2)}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                removeItem(item['id']);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Tk.${calculateTotalPrice(cartItems).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: buyNow,
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
                              Icons.shopping_bag,
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
                    ),
                  ],
                );
        },
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({Key? key}) : super(key: key);

//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   final User? user = FirebaseAuth.instance.currentUser;

//   Future<List<Map<String, dynamic>>> getCartItems() async {
//     if (user == null) {
//       return [];
//     }

//     try {
//       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//           .collection('CartItems')
//           .where('userId', isEqualTo: user!.uid)
//           .get();

//       List<Map<String, dynamic>> cartItems = cartSnapshot.docs.map((doc) {
//         var data = doc.data() as Map<String, dynamic>;
//         data['id'] = doc.id; // Store document ID to use it for deletion
//         return data;
//       }).toList();

//       return cartItems;
//     } catch (error) {
//       print('Error fetching cart items: $error');
//       return [];
//     }
//   }

//   double calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
//     double totalPrice = 0.0;
//     for (var item in cartItems) {
//       totalPrice += item['totalPrice'];
//     }
//     return totalPrice;
//   }

//   Future<void> buyNow() async {
//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('You need to be signed in to purchase.')),
//       );
//       return;
//     }

//     try {
//       // Show a confirmation dialog
//       bool? confirmed = await showDialog<bool>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Confirm Purchase'),
//           content: const Text('Do you want to proceed with the payment?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: const Text('Confirm'),
//             ),
//           ],
//         ),
//       );

//       if (confirmed != true) {
//         return; // Exit if the user cancels
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Proceeding to payment...')),
//       );

//       // Clear the cart after purchase
//       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//           .collection('CartItems')
//           .where('userId', isEqualTo: user!.uid)
//           .get();

//       for (var doc in cartSnapshot.docs) {
//         await doc.reference.delete();
//       }

//       // Navigate back to the main screen or show a confirmation message
//       Navigator.of(context).pop();
//     } catch (error) {
//       print('Error during purchase: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to complete purchase')),
//       );
//     }
//   }

//   Future<void> removeItem(String id) async {
//     try {
//       await FirebaseFirestore.instance.collection('CartItems').doc(id).delete();
//       setState(() {}); // Refresh the UI after deleting the item
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Item removed from cart')),
//       );
//     } catch (error) {
//       print('Error removing item: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to remove item')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: getCartItems(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Center(child: Text('Error fetching cart items.'));
//           }
//           final cartItems = snapshot.data ?? [];
//           return cartItems.isEmpty
//               ? const Center(child: Text('Your cart is empty'))
//               : Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartItems.length,
//                         itemBuilder: (context, index) {
//                           final item = cartItems[index];
//                           return ListTile(
//                             title: Text(item['title']),
//                             subtitle: Text(
//                                 'Quantity: ${item['quantity']} | Total: Tk.${item['totalPrice'].toStringAsFixed(2)}'),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 removeItem(item['id']);
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Total Price:',
//                             style: TextStyle(
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Tk.${calculateTotalPrice(cartItems).toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                       child: ElevatedButton(
//                         onPressed: buyNow,
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.blue[900],
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 16.0,
//                             horizontal: 32.0,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                         child: const Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.shopping_bag,
//                               color: Colors.white,
//                             ),
//                             SizedBox(width: 8.0),
//                             Text(
//                               "Buy Now",
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//         },
//       ),
//     );
//   }
// }
