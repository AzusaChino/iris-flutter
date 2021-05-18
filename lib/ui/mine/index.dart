import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MinePageState createState() => new MinePageState();
}

class MinePageState extends State<MinePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.sentiment_satisfied_alt_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
