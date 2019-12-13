import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hesap Makinesi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hesapla Beni Scoty'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  double num = 0;
  double num2 = 0;
  String operation = "";
  String outputoperation = "";
  String lastoperation = "";
  onClickBtn(String txt) {
    if (txt == "C") {
      num = 0;
      num2 = 0;
      output = "0";
      outputoperation = "";
      operation = "";
    } else if (txt == "+" || txt == "-" || txt == "/" || txt == "x") {
      num = double.parse(output);
      operation = txt;
      output = "0";
    } else if (txt == ".") {
      if (output.contains(".")) {
        return;
      } else {
        output = output + txt;
      }
    } else if (txt == "%") {
      num = double.parse(output);
      output = (num / 100).toString();
    } else if (txt == "√") {
      num = double.parse(output);
      output = sqrt(num).toString();
    } else if (txt == "=") {
      num2 = double.parse(output);
      if (operation == "+") {
        output = (num + num2).toString();
      }
      if (operation == "-") {
        output = (num - num2).toString();
      }
      if (operation == "/") {
        output = (num / num2).toString();
      }
      if (operation == "x") {
        output = (num * num2).toString();
      }
      num = 0;
      num2 = 0;
      operation = "";
    } else {
      if (output == "0") {
        output = txt;
      } else {
        output = output + txt;
      }
    }

    setState(() {
      output = output;
    });
  }

  Widget buildBtn(String txt) {
    return Expanded(
        child: MaterialButton(
      onPressed: () => {onClickBtn(txt)},
      padding: EdgeInsets.all(20),
      child: Text(
        txt,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Card(
          child: Container(
              child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding:
                      new EdgeInsets.symmetric(vertical: 150, horizontal: 12),
                  child: Text(
                    "=" + output,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(105),
                // ),
                Divider(
                  color: Colors.blue,
                  thickness: 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        buildBtn("√"),
                        Expanded(
                          child: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  output = "0";
                                  outputoperation = "";
                                });
                              },
                              child: MaterialButton(
                                padding: EdgeInsets.all(22),
                                onPressed: () {
                                  output =
                                      output.substring(0, output.length - 1);
                                  if (output == "") {
                                    output = "0";
                                  } else {
                                    output = output;
                                  }
                                  setState(() {
                                    outputoperation = "";
                                    output = output;
                                  });
                                },
                                child: Icon(Icons.arrow_back),
                              )),
                        ),
                        buildBtn("%"),
                        buildBtn("/"),
                      ],
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        buildBtn("7"),
                        buildBtn("8"),
                        buildBtn("9"),
                        buildBtn("x"),
                      ],
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        buildBtn("4"),
                        buildBtn("5"),
                        buildBtn("6"),
                        buildBtn("-"),
                      ],
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        buildBtn("1"),
                        buildBtn("2"),
                        buildBtn("3"),
                        buildBtn("+"),
                      ],
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        buildBtn("C"),
                        buildBtn("0"),
                        buildBtn("."),
                        buildBtn("="),
                      ],
                    )
                  ],
                )
              ]),
            ],
          )),
        ));
  }
}
