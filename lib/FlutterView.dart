import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class FlutterView extends StatefulWidget {
    @override
    _FlutterView createState() => _FlutterView();
}

class _FlutterView extends State<FlutterView> {
    static const String _channel = 'increment';
    static const String _pong = 'pong';
    static const String _emptyMessage = '';
    static const BasicMessageChannel<String> platform =
    BasicMessageChannel<String>(_channel, StringCodec());

    int _counter = 0;

    @override
    void initState() {
        super.initState();
        platform.setMessageHandler(_handlePlatformIncrement);
    }

    Future<String> _handlePlatformIncrement(String message) async {
        setState(() {
            _counter++;
        });
        return _emptyMessage;
    }

    void _sendFlutterIncrement() {
        setState(() {
            _counter++;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Expanded(
                        child: Center(
                                child: Text(
                                        'Platform button tapped $_counter time${ _counter == 1 ? '' : 's' }.',
                                        style: const TextStyle(fontSize: 17.0))
                        ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
                        child: Row(
                            children: <Widget>[
                                Icon(Icons.home),
                                const Text('Flutter', style: TextStyle(fontSize: 30.0)),
                            ],
                        ),
                    ),
                ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: _sendFlutterIncrement,
                child: const Icon(Icons.add),
            ),
        );
    }
}