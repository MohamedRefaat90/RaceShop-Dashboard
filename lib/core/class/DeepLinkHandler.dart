// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';


// class DeepLinkHandler {
//   bool _initialURILinkHandled = false;
//   Uri? _initialURI;
//   Uri? _currentURI;
//   Object? _err;

//   Future<void> initURIHandler() async {
//     // 1
//     if (!_initialURILinkHandled) {
//       _initialURILinkHandled = true;
//       // 2
//       Fluttertoast.showToast(
//           msg: "Invoked _initURIHandler",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.green,
//           textColor: Colors.white);
//       try {
//         // 3
//         final initialURI = await getInitialUri();
//         // 4
//         if (initialURI != null) {
//           print("Initial URI received $initialURI");

//           _initialURI = initialURI;
//         } else {
//           print("Null Initial URI received");
//         }
//       } on PlatformException {
//         // 5
//         print("Failed to receive initial uri");
//       } on FormatException {
//         // 6

//         print('Malformed Initial URI received');
//       }
//     }
//   }
// }
