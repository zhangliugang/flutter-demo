import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef void PressOperationCallback(Operator op);

abstract class Operator {
  String display;
  Color color;
  num calculate(num first, num second);
}

class AddOperator extends Operator {
  @override
  // TODO: implement display
  String get display => '+';
  @override
  // TODO: implement color
  Color get color => Colors.pink[300];

  @override
  num calculate(num first, num second) {
    // TODO: implement calculate
    return first + second;
  }

}

class SubOperator extends Operator {
  @override
  // TODO: implement display
  String get display => '-';
  @override
  // TODO: implement color
  Color get color => Colors.orange[300];
  @override
  num calculate(num first, num second) {
    // TODO: implement calculate
    return first - second;
  }

}

class MultiOperator extends Operator {
  @override
  // TODO: implement display
  String get display => '*';
  @override
  // TODO: implement color
  Color get color => Colors.lightBlue[300];
  @override
  num calculate(num first, num second) {
    // TODO: implement calculate
    return first * second;
  }

}

class DivisionOperator extends Operator {
  @override
  // TODO: implement display
  String get display => '/';
  @override
  // TODO: implement color
  Color get color => Colors.purple[300];
  @override
  num calculate(num first, num second) {
    // TODO: implement calculate
    return first / second;
  }

}

class OperatorButton extends StatefulWidget {
  OperatorButton({@required this.op, this.onPress})
    : assert(op != null);
  final Operator op;
  final PressOperationCallback onPress;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OperatorButtonState();
  }

}

class _OperatorButtonState extends State<OperatorButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            if (widget.onPress != null) {
              widget.onPress(widget.op);
              setState(() {
                pressed = true;
              });
              Future.delayed(
                const Duration(milliseconds: 200),
                  () => setState(() {
                    pressed = false;
                  }));
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: pressed ? Color.alphaBlend(Colors.white30, widget.op.color) :
                  widget.op.color,
              borderRadius: BorderRadius.all(Radius.circular(100.0))
            ),
            child: Text(
              '${widget.op.display}',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

}

class OperatorGroup extends StatelessWidget {
  OperatorGroup(this.onOperatorButtonPressed);
  final PressOperationCallback onOperatorButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        OperatorButton(
          op: AddOperator(),
          onPress: onOperatorButtonPressed,
        ),
        OperatorButton(
          op: SubOperator(),
          onPress: onOperatorButtonPressed,
        ),
        OperatorButton(
          op: MultiOperator(),
          onPress: onOperatorButtonPressed,
        ),
        OperatorButton(
          op: DivisionOperator(),
          onPress: onOperatorButtonPressed,
        )
      ],
    );
  }

}