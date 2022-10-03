import 'package:flutter/material.dart';
import 'dart:async';
import 'calc.dart';

//Stream関数は、データを監視し続け,変化するデータによって画面を更新する、という処理が得意

//1,ボタンが押されたら、購読状態の_UpdateTextArea関数に値を流す
//2,displayに式表示
//3, =が押されたら元々PutList関数によって値の整理がされたnumberリストとopリストを使ってFinalResultで値を算出
//4,num_resultがFinalResultから値を受け取り、表示
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Calculator'),
        ),
        body: Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(),
                Keyboard(),
              ],
            )),
      ),
    );
  }
}

class TextField extends StatefulWidget {
  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  String num_result = '';

  void _UpdateTextArea(String selectedButton) {
    setState(() {
      if (selectedButton == 'AC') {
        num_result = '';
      } else if (selectedButton == '=') {
        num_result = '';
        num_result = Calculator.FinalResult();
      } else {
        num_result += selectedButton;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 200,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            num_result,
            style: TextStyle(
              color: Colors.white,
              fontSize: 60,
            ),
          ),
        ),
      ),
    );
  }

  static final controller = StreamController.broadcast();

//initState(最初に一度呼ばれるWidgetツリーの初期化を実行)
  void initState() {
    controller.stream.listen((event) {
      _UpdateTextArea(event);
    });
    controller.stream.listen((event) {
      Calculator.PutList(event);
    });//streamから都度値を受け取り、PutList関数に値を流す
  }
}

class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                gray1button('AC'),
                gray1button('±'),
                gray1button('%'),
                orangebutton('÷'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Gray2button('7'),
                Gray2button('8'),
                Gray2button('9'),
                orangebutton('×'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Gray2button('4'),
                Gray2button('5'),
                Gray2button('6'),
                orangebutton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Gray2button('1'),
                Gray2button('2'),
                Gray2button('3'),
                orangebutton('+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Gray2button('0'),
                Gray2button('00'),
                Gray2button('.'),
                orangebutton('='),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class gray1button extends StatelessWidget {
  String keyvalue;
  gray1button(this.keyvalue);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: FloatingActionButton(
        onPressed: () {
          _TextFieldState.controller.sink.add(keyvalue);
        },//_TextFieldStateに値を流す
        backgroundColor: Color(0xFFc0c0c0),
        child: Text(
          keyvalue,
          style: TextStyle(
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}

class Gray2button extends StatelessWidget {
  final keyvalue;
  Gray2button(this.keyvalue);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: FloatingActionButton(
        onPressed: () {
          _TextFieldState.controller.sink.add(keyvalue);
        },
        backgroundColor: Color(0xFF383c3c),
        child: Text(
          keyvalue,
          style: TextStyle(
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}

class orangebutton extends StatelessWidget {
  final keyvalue;
  orangebutton(this.keyvalue);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: FloatingActionButton(
        onPressed: () {
          _TextFieldState.controller.sink.add(keyvalue);
        },
        backgroundColor: Colors.orange,
        child: Text(
          keyvalue,
          style: TextStyle(
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}
