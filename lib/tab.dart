import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'guide.dart';
import 'alert.dart';

final tab = CupertinoTabScaffold(
  tabBar: CupertinoTabBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Image.asset("assets1/BLS_icon_tab_chat@2x.png"),
          activeIcon: Image.asset("assets1/icon@2x.png"),
          title: Text("A")),
      BottomNavigationBarItem(
          icon: Image.asset("assets1/BLS_icon_tab_chat@2x.png"),
          activeIcon: Image.asset("assets1/icon@2x.png"),
          title: Text("B")),
      BottomNavigationBarItem(
          icon: Image.asset("assets1/BLS_icon_tab_chat@2x.png"),
          activeIcon: Image.asset("assets1/icon@2x.png"),
          title: Text("C")),
      BottomNavigationBarItem(
          icon: Image.asset("assets1/BLS_icon_tab_chat@2x.png"),
          activeIcon: Image.asset("assets1/icon@2x.png"),
          title: Text("D"))
    ]
  ),
  tabBuilder: (BuildContext context, int index) {
    Future<void> _neverSatisfied() async {
      return showCupertinoModalPopup(
        context: context,
//        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text('字体大小'),
            cancelButton: CupertinoActionSheetAction(
              child: Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
              isDestructiveAction: true,
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('中'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text('大'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text('超大'),
                onPressed: () {
                  Navigator.pop(context);
                }
              )
            ],
          );
        },
      );
    }

    return CupertinoTabView(
      builder: (BuildContext context) {
        if (index == 0) {
          return GuidePage();
        }
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Page 1 of tab $index'),
          ),
          child: Center(
            child: CupertinoButton(
              child: const Text('Next page'),
              onPressed: () {
                _neverSatisfied();
              },
            ),
          ),
        );
      },
    );
  },
);
