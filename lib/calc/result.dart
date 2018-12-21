import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter1/calc/operator.dart';

typedef void PressOperationCallback(display);

class Result {
  Result();

  String firstNum;
  String secondNum;
  Operator op;
  num result;
}

class ResultButton extends StatefulWidget {
  ResultButton({@required this.display, @required this.color, this.onPress});

  final String display;
  final Color color;
  final PressOperationCallback onPress;

  @override
  State<StatefulWidget> createState() => _ResultButtonState();
}

class _ResultButtonState extends State<ResultButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 24.0),
            child: GestureDetector(
              onTap: () {
                if (widget.onPress != null) {
                  widget.onPress(widget.display);
                  setState(() {
                    pressed = true;
                  });
                  Future.delayed(
                      const Duration(milliseconds: 200),
                      () => setState(() {
                            pressed = false;
                          })
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: pressed ? Colors.grey[200] : null,
                    border: Border.all(color: widget.color, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Text(
                  '${widget.display}',
                  style: TextStyle(
                      fontSize: 36.0,
                      color: widget.color,
                      fontWeight: FontWeight.w300),
                ),
              ),
            )
        )
    );
  }
}


class ResultDisplay extends StatefulWidget {
  ResultDisplay({this.result});
  final String result;

  @override
  State<StatefulWidget> createState() => _ResultDisplayState();
}

class _ResultDisplayState extends State<ResultDisplay> {
  GlobalKey k = GlobalKey();
  RenderBox box;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      widget.result,
      softWrap: false,
      overflow: TextOverflow.fade,
      textScaleFactor: 7.5 / widget.result.length > 1.0 ? 1.0 : 7.5 / widget.result.length,
      key: k,
      style: new TextStyle(
          fontSize: 80.0,
          fontWeight: FontWeight.w800,
          foreground: Paint()..shader = getTextGradient(box)),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _recordSize());
  }

  void _recordSize() {
    setState(() {
      box = k.currentContext.findRenderObject();
    });
  }

  Shader getTextGradient(RenderBox renderBox) {
    if (renderBox == null) return null;
    return LinearGradient(
        colors: <Color>[Color(0xff12C2E9), Color(0xffC471ED), Color(0xffF64F59)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
    ).createShader(Rect.fromLTWH(
        renderBox.localToGlobal(Offset.zero).dx,
        renderBox.localToGlobal(Offset.zero).dy,
        renderBox.size.width,
        renderBox.size.height));
  }
}

class HistoryBlock extends StatelessWidget {

  final Result result;

  HistoryBlock({this.result});
  @override
  Widget build(BuildContext context) {
    var text = '';
    if (result.secondNum != null) {
      text = '${result.firstNum} ${result.op.display} ${result.secondNum}';
    } else if (result.op != null) {
      text = '${result.firstNum} ${result.op.display}';
    } else if (result.firstNum != null) {
      text = '${result.firstNum}';
    }
    return Padding(
      padding: EdgeInsets.only(top: 6.0, bottom: 16.0, right: 16.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: result.op != null ? result.op.color :Colors.white54,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Text(text,
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}