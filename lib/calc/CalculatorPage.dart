import 'package:flutter1/calc/result.dart';
import 'package:flutter1/calc/operator.dart';
import 'package:flutter1/calc/number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CalculatorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalculatorPageState();
  }

}

class _CalculatorPageState extends State<CalculatorPage> {
  List<Result> results = [];
  String currentDisplay = '0';

  onResultButtonPressed(display) {
    if (results.length > 0) {
      var result = results.last;
      if (display == '=') {
        result.result = result.op.calculate(double.parse(result.firstNum),
            double.parse(result.secondNum));
      } else if (display == '<<') {
        results.removeLast();
      }
      pickCurrentDisplay();
    }
  }

  onOperatorButtonPressed(Operator op) {
    if (results.length > 0) {
      var result = results.last;
      if (result.result != null) {
        var newRes = Result();
        newRes.firstNum = currentDisplay;
        newRes.op = op;
        results.add(newRes);
      } else if (result.firstNum != null) {
        result.op = op;
      }
    }
    pickCurrentDisplay();
  }

  onNumberButtonPressed(Number number) {
    var result = results.length > 0 ? results.last : Result();
    if (result.firstNum == null || result.op == null) {
      result.firstNum = number.apply(currentDisplay);
    } else if (result.result == null) {
      if (result.secondNum == null) {
        currentDisplay = '0';
      }
      result.secondNum = number.apply(currentDisplay);
    } else {
      var newRes = Result();
      currentDisplay = '0';
      newRes.firstNum = number.apply(currentDisplay);
      results.add(newRes);
    }
    if (results.length == 0) {
      results.add(result);
    }
    pickCurrentDisplay();
  }

  pickCurrentDisplay() {
    this.setState(() {
      var display = '0';
      results.removeWhere((r) => r.firstNum == null && r.op == null && r.secondNum == null);
      if (results.length > 0) {
        var result = results.last;
        if (result.result != null) {
          display = format(result.result);
        } else if (result.secondNum != null && result.op != null) {
          display = result.secondNum;
        } else if (result.firstNum != null) {
          display = result.firstNum;
        }
      }
      currentDisplay = display;
    });
  }

  String format(num number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            Expanded(
              key: Key('Current_display'),
              flex: 2,
              child: FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Container(
                  color: Colors.lightBlue[300],
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16.0),
                  child: ResultDisplay(result: currentDisplay),
                ),
              ),
            ),
            Expanded(
              key: Key('History_Display'),
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Container(
                  color: Colors.black54,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    children: results.reversed.map((result) {
                      return HistoryBlock(result: result);
                    }).toList(),
                  ),
                ),
              ),
            ),
            Expanded(
              key: Key('Number_Button_Line_1'),
              flex: 1,
              child: NumberButtonLine(
                array: [
                  NormalNumber('1'),
                  NormalNumber('2'),
                  NormalNumber('3')
                ],
                onPress: onNumberButtonPressed,
              ),
            ),
            Expanded(
              key: Key('Number_Button_Line_2'),
              flex: 1,
              child: NumberButtonLine(
                array: [
                  NormalNumber('4'),
                  NormalNumber('5'),
                  NormalNumber('6')
                ],
                onPress: onNumberButtonPressed,
              ),
            ),
            Expanded(
              key: Key('Number_Button_Line_3'),
              flex: 1,
              child: NumberButtonLine(
                array: [
                  NormalNumber('7'),
                  NormalNumber('8'),
                  NormalNumber('9')
                ],
                onPress: onNumberButtonPressed,
              ),
            ),
            Expanded(
              key: Key('Number_Button_Line_4'),
              flex: 1,
              child: NumberButtonLine(
                array: [SymbolNumber(), NormalNumber('0'), DecimalNumber()],
                onPress: onNumberButtonPressed,
              ),
            ),
            Expanded(
              key: Key('Operator_Group'),
              flex: 1,
              child: OperatorGroup(onOperatorButtonPressed),
            ),
            Expanded(
              key: Key('Result_Button_Area'),
              flex: 1,
              child: Row(
                children: <Widget>[
                  ResultButton(
                    display: '<<',
                    color: Colors.red,
                    onPress: onResultButtonPressed,
                  ),
                  ResultButton(
                    display: '=',
                    color: Colors.green,
                    onPress: onResultButtonPressed,
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }

}
