import 'dart:async';
import 'dart:io';

import 'package:classbe/screens/navigator_global_key.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InternetConnectionService {
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // listenInternetStatus() {
  //   initConnectivity();
  //   _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  // }

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result;

  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   return _updateConnectionStatus(result);
  // }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //     case ConnectivityResult.mobile:
  //       print(result.toString());
  //       try {
  //         final pingResult = await InternetAddress.lookup('example.com');
  //         if (pingResult.isNotEmpty && pingResult[0].rawAddress.isNotEmpty) {
  //           final scaffold = ScaffoldMessenger.of(
  //               NavigatorGlobalKey.navigatorKey.currentContext);
  //           scaffold.hideCurrentSnackBar();
  //           print('connected');
  //         }
  //       } on SocketException catch (_) {
  //         print('not connected');

  //         if (NavigatorGlobalKey.navigatorKey.currentContext != null) {
  //           final scaffold = ScaffoldMessenger.of(
  //               NavigatorGlobalKey.navigatorKey.currentContext);
  //           scaffold.showSnackBar(
  //             SnackBar(
  //               backgroundColor: Colors.red,
  //               duration: Duration(minutes: 60),
  //               content: const Text(
  //                 'Check your internet connection.',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           );
  //         }
  //       }
  //       break;
  //     case ConnectivityResult.none:
  //       if (NavigatorGlobalKey.navigatorKey.currentContext != null) {
  //         final scaffold = ScaffoldMessenger.of(
  //             NavigatorGlobalKey.navigatorKey.currentContext);
  //         scaffold.showSnackBar(
  //           SnackBar(
  //             backgroundColor: Colors.red,
  //             duration: Duration(minutes: 60),
  //             content: const Text(
  //               'Check your internet connection.',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         );
  //       }
  //       break;
  //     default:
  //       print('Failed to get connectivity.');
  //       break;
  //   }
  // }
}
