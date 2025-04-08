// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'package:stocks/src/view.dart';

import 'package:stocks/src/controller.dart' as c;

///
typedef ModeUpdater = void Function(StockMood mode);

///
class StockHome extends StatefulWidget {
  ///
  const StockHome({super.key});

  @override
  _StockHomeState createState() => _StockHomeState();
}

///
class _StockHomeState extends StateX<StockHome> {
  ///
  _StockHomeState() : super(controller: c.StockHomeController()) {
    con = controller as c.StockHomeController;
  }

  /// The State object's Controller
  late c.StockHomeController con;

  @override
  Widget buildAndroid(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawerDragStartBehavior: DragStartBehavior.down,
        key: con.scaffoldKey,
        appBar: con.widget.appBar,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Create company',
//      backgroundColor: Theme.of(con.context).accentColor,
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) => const Column(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Company Name',
                    ),
                  ),
                  Text('(This demo is not yet complete.)'),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        drawer: _drawer,
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.down,
          children: <Widget>[
            con.widget.marketTab,
            con.widget.portfolioTab,
          ],
        ),
      ),
    );
  }

  /// The Drawer for the interface
  Widget get _drawer => Drawer(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          dragStartBehavior: DragStartBehavior.down,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Stocks',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.assessment),
              title: Text('Stock List'),
              selected: true,
            ),
            const ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Account Balance'),
              enabled: false,
            ),
            if (App.inDebugMode) // Display only on the developer's computer.
              ListTile(
                leading: const Icon(Icons.dvr),
                title: const Text('Printout App Information'),
                onTap: () => _printAppInfo(context),
              ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.thumb_up),
              title: const Text('Optimistic'),
              trailing: con.widget.optimistic,
              onTap: con.onTap.optimistic,
            ),
            ListTile(
              leading: const Icon(Icons.thumb_down),
              title: const Text('Pessimistic'),
              trailing: con.widget.pessimistic,
              onTap: con.onTap.pessimistic,
            ),
            const Divider(),
            if (App.inDebugMode)
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Debug Tools'),
                onTap: () => con.onTap.devTools(context),
              ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('About'),
              onTap: () => con.onTap.about(context),
            ),
          ],
        ),
      );

  Future<void> _printAppInfo(BuildContext context) async {
    //
    String infoType = 'app';
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final info = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          App.dependOnInheritedWidget(context);
          return AlertDialog(
            title: Text(
              'App Info',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            titlePadding: const EdgeInsets.only(left: 10, top: 20),
            contentPadding: const EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, '');
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, infoType);
                },
                child: const Text('OK'),
              )
            ],
            content: SizedBox(
              width: 80.w, // % of screen width
              height: 50.h, // % of screen height
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Textual representation of this app:'),
                const Divider(),
                Flexible(
                  child: ListTile(
                    leading: Radio<String>(
                      value: 'app',
                      groupValue: infoType,
                      onChanged: (v) {
                        infoType = v!;
                        App.notifyClients();
                      },
                    ),
                    title: const Text('App representation'),
                  ),
                ),
                Flexible(
                  child: ListTile(
                    leading: Radio<String>(
                      value: 'render',
                      groupValue: infoType,
                      onChanged: (v) {
                        infoType = v!;
                        App.notifyClients();
                      },
                    ),
                    title: const Text('Render Tree'),
                  ),
                ),
                Flexible(
                  child: ListTile(
                    leading: Radio<String>(
                      value: 'layer',
                      groupValue: infoType,
                      onChanged: (v) {
                        infoType = v!;
                        App.notifyClients();
                      },
                    ),
                    title: const Text('Layer Tree'),
                  ),
                ),
                Flexible(
                  child: ListTile(
                    leading: Radio<String>(
                      value: 'semantics',
                      groupValue: infoType,
                      onChanged: (v) {
                        infoType = v!;
                        App.notifyClients();
                      },
                    ),
                    title: const Text('Semantics Tree'),
                  ),
                ),
                const Divider(),
                if (portrait)
                  const Flexible(child: Text('To view Log In Android Studio:')),
                if (portrait)
                  const Flexible(
                      child: Text(
                          'Help Menu -> Show log in Explorer (for Windows)')),
                if (portrait)
                  const Flexible(
                      child: Text(
                          'Help Menu -> Show log in Finder (for Mac users)')),
                if (portrait)
                  const Flexible(child: Text('OUTPUTS ALSO TO CONSOLE')),
              ]),
            ),
          );
        });

    Function? func;

    switch (info) {
      case 'app':
        // Print a string representation of the currently running app.
        // https://docs.flutter.dev/testing/code-debugging#widget-tree
        func = debugDumpApp;
        break;
      case 'render':
        // Prints a textual representation of the entire render tree.
        // https://docs.flutter.dev/testing/code-debugging#render-tree
        func = debugDumpRenderTree;
        break;
      case 'layer':
        // Prints a textual representation of the entire layer tree
        // https://docs.flutter.dev/testing/code-debugging#layer-tree
        func = debugDumpLayerTree;
        break;
      case 'semantics':
        // Prints a textual representation of the entire semantics tree.
        // https://docs.flutter.dev/testing/code-debugging#semantics-tree
        func = debugDumpSemanticsTree;
        break;
    }

    try {
      if (func != null) {
        if (func == debugDumpSemanticsTree) {
          func(DebugSemanticsDumpOrder.traversalOrder);
        } else {
          func();
        }
      }
    } catch (e, stack) {
      debugPrint('Exception while printing app info:\n$e\n$stack');
    }
  }

  // The Cupertino interface was not implemented.
  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);
}

/// Displayed in segments of the App not yet finished.
class NotImplementedDialog extends StatelessWidget {
  ///
  const NotImplementedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Not Implemented'),
      content: const Text('This feature has not yet been implemented.'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: debugDumpApp,
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.dvr,
                size: 18,
              ),
              Container(
                width: 8,
              ),
              const Text('DUMP APP TO CONSOLE'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('OH WELL'),
        ),
      ],
    );
  }
}
