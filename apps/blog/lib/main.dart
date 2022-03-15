import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ronbb\'s blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _rawContent = "";

  Widget _rowItem({required Widget child}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              _rowItem(
                child: TextField(
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Edit'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _rawContent = value;
                    });
                  },
                ),
              ),
              _rowItem(
                child: Markdown(
                  data: _rawContent,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
