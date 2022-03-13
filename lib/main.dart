import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Event Channel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Belajar Event Channel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final eventChannel = const EventChannel('belajar_flutter_event_channel');
  final valueNotifier = ValueNotifier<String>('value');

  @override
  void initState() {
    eventChannel.receiveBroadcastStream().listen((event) {
      if (event is String) {
        valueNotifier.value = event;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ValueListenableBuilder<String>(
          valueListenable: valueNotifier,
          builder: (BuildContext context, String value, Widget? child) {
            return Text(
              value,
              style: Theme.of(context).textTheme.headline6,
            );
          },
        ),
      ),
    );
  }
}