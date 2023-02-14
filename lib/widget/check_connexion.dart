import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:movie_db/screen/wrapper.dart';

class CheckConnexion extends StatefulWidget {
  @override
  _CheckConnexionState createState() => _CheckConnexionState();
}

class _CheckConnexionState extends State<CheckConnexion> {
  bool _isConnected = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _setConnected(true);
      } else {
        _setConnected(false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  void _setConnected(bool isConnected) {
    setState(() {
      _isConnected = isConnected;
      if (isConnected) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Wrapper()),
        );
      }
    });
  }

  void _refreshWidget() {
    _setConnected(_isConnected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      height: 300,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _isConnected
              ? Container()
              : Text(
                  'No internet connection',
                  style: Theme.of(context).textTheme.headline6?.apply(
                        color: Colors.white,
                      ),
                ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _refreshWidget,
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
