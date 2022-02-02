import 'package:calculator_app/view/widgets/calButton.dart';
import 'package:calculator_app/view/widgets/results.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPage();
}

enum Operator { plus, minus, multiply, divide, mod }

class _CalculatorPage extends State<CalculatorPage> {
  Operator? op;
  dynamic result = "";

  final _buttonAction = <String, VoidCallback>{};
  num? _leftNum;
  //map of operators
  final _operatorStrings = <Operator, String>{
    Operator.divide: "÷",
    Operator.minus: "-",
    Operator.multiply: "*",
    Operator.plus: "+",
  };

  num? _rightNum;

  @override
  void initState() {
    // TODO: implement initState
    //key:values pairs for callback
    _buttonAction.addAll({
      "1": () => _numIn(1),
      "2": () => _numIn(2),
      "3": () => _numIn(3),
      "4": () => _numIn(4),
      "5": () => _numIn(5),
      "6": () => _numIn(6),
      "7": () => _numIn(7),
      "8": () => _numIn(8),
      "9": () => _numIn(9),
      "0": () => _numIn(0),
      "AC": () => _reset(),
      "+/-": () => _frac(),
      ".": () => _decimalV("."),
      "÷": () => _opIn(Operator.divide),
      "x": () => _opIn(Operator.multiply),
      "+": () => _opIn(Operator.plus),
      "%": () => _opIn(Operator.mod),
      "-": () => _opIn(Operator.minus),
      "=": () => _answer(),
    });
    super.initState();
  }

  String get _calc {
    // Concatenate Strings for the input nums
    return [
      _leftNum?.toString() ?? "",
      _operatorStrings[op] ?? "",
      _rightNum?.toString() ?? ""
    ].where((element) => element != "").join(' ');
  }

  void _decimalV(string) {
    setState(() {
      if (op == null) {
        if (_leftNum != null) {
          var check = _leftNum.toString();
          check += string;
          print(check);
          _leftNum = int.tryParse(check);
        }
      } else {
        if (_leftNum != null) {
          string = _rightNum.toString() + string;
          _rightNum = int.tryParse(string);
        }
      }
    });
  }

  void _frac() {
    setState(() {
      if (op == null) {
      } else {}
    });
  }

  //clearing all values
  void _reset() {
    setState(() {
      _leftNum = null;
      _rightNum = null;
      op = null;
      result = "";
    });
  }

// func to input nums Onclick through callback
  void _numIn(int num) {
    setState(() {
      if (op == null) {
        _leftNum = (_leftNum ?? 0) * 10 +
            num; // loop once = num :(5), loop twice num*10+num :(5*10=50,50+5=55);
      } else {
        _rightNum = (_rightNum ?? 0) * 10 + num;
      }
    });
  }

  //set the operator
  void _opIn(Operator opr) {
    setState(() {
      op = opr;
    });
  }

// the "=" calculation
  void _answer() {
    if (op == null || _leftNum == null || _rightNum == null) {
      return;
    }
    setState(() {
      if (op != null) {
        if (op == Operator.divide) {
          result = (_leftNum! / _rightNum!);
        } else if (op == Operator.plus) {
          result = (_leftNum! + _rightNum!);
        } else if (op == Operator.multiply) {
          result = (_leftNum! * _rightNum!);
        } else if (op == Operator.mod) {
          result = (_leftNum! % _rightNum!);
        } else if (op == Operator.minus) {
          result = (_leftNum! - _rightNum!);
        }
      }
      _leftNum = null;
      _rightNum = null;
      op = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                  child: ResultDisplay(
                num: _calc,
                res: result,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Calbutton(
                      num: "AC",
                      onTap: _buttonAction["AC"]!,
                    ),
                    Calbutton(
                      num: "+/-",
                      onTap: _buttonAction["+/-"]!,
                    ),
                    Calbutton(num: "%", onTap: _buttonAction["%"]!),
                    Calbutton(
                        num: "÷",
                        color: Colors.amber,
                        onTap: _buttonAction["÷"]!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Calbutton(num: "7", onTap: _buttonAction["7"]!),
                    Calbutton(num: "8", onTap: _buttonAction["8"]!),
                    Calbutton(num: "9", onTap: _buttonAction["9"]!),
                    Calbutton(
                        num: "x",
                        color: Colors.amber,
                        onTap: _buttonAction["x"]!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Calbutton(num: "4", onTap: _buttonAction["4"]!),
                    Calbutton(num: "5", onTap: _buttonAction["5"]!),
                    Calbutton(num: "6", onTap: _buttonAction["6"]!),
                    Calbutton(
                        num: "-",
                        color: Colors.amber,
                        onTap: _buttonAction["-"]!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Calbutton(num: "1", onTap: _buttonAction["1"]!),
                    Calbutton(num: "2", onTap: _buttonAction["2"]!),
                    Calbutton(num: "3", onTap: _buttonAction["3"]!),
                    Calbutton(
                        num: "+",
                        color: Colors.amber,
                        onTap: _buttonAction["+"]!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Calbutton(num: "0", onTap: _buttonAction["0"]!),
                    Calbutton(num: ".", onTap: _buttonAction["."]!),
                    Calbutton(
                        num: "=",
                        color: Colors.amber,
                        onTap: _buttonAction["="]!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
