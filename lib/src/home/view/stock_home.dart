// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'package:stocks/src/view.dart';

import 'package:stocks/src/controller.dart' as c;

///
typedef ModeUpdater = void Function(StockMode mode);

///
enum StockHomeTab { market, portfolio }

///
class StockHome extends StatefulWidget {
  ///
  const StockHome({super.key});

  @override
  StockHomeState createState() => StockHomeState();
}

///
class StockHomeState extends StateX<StockHome> {
  ///
  StockHomeState() : super(c.StockHomeController()) {
    con = controller as c.StockHomeController;
  }

  ///
  late c.StockHomeController con;

  // _degree01, _degree02 & _degree03 are also available.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawerDragStartBehavior: DragStartBehavior.down,
        key: con.scaffoldKey,
        appBar: con.widget.appBar,
        floatingActionButton: con.widget.floatingButton.createCompany,
        drawer: Drawer(
          child: ListView(
            dragStartBehavior: DragStartBehavior.down,
            children: <Widget>[
              const DrawerHeader(child: Center(child: Text('Stocks'))),
              con.widget.stockList,
              con.widget.accountBalance,
              con.widget.dumpConsole,
              const Divider(),
              con.widget.optimistic,
              con.widget.pessimistic,
              const Divider(),
              con.widget.settings,
              con.widget.about,
            ],
          ),
        ),
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

  Widget get _degree01 => DefaultTabController(
        length: 2,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: con.scaffoldKey,
          appBar: con.widget.appBar,
          floatingActionButton: con.widget.floatingButton.createCompany,
          drawer: Drawer(
            child: ListView(
              dragStartBehavior: DragStartBehavior.down,
              children: <Widget>[
                const DrawerHeader(child: Center(child: Text('Stocks'))),
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
                ListTile(
                  leading: const Icon(Icons.dvr),
                  title: const Text('Dump App to Console'),
                  onTap: con.onTap.dumpConsole,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.thumb_up),
                  title: const Text('Optimistic'),
                  trailing: Radio<StockMode>(
                    value: StockMode.optimistic,
                    groupValue: c.AppStocks.stockMode,
                    onChanged: con.handleStockModeChange,
                  ),
                  onTap: con.onTap.optimistic,
                ),
                ListTile(
                  leading: const Icon(Icons.thumb_down),
                  title: const Text('Pessimistic'),
                  trailing: Radio<StockMode>(
                    value: StockMode.pessimistic,
                    groupValue: c.AppStocks.stockMode,
                    onChanged: con.handleStockModeChange,
                  ),
                  onTap: con.onTap.pessimistic,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    con.onTap.settings(con.context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('About'),
                  onTap: () {
                    con.onTap.about(con.context);
                  },
                ),
              ],
            ),
          ),
          body: TabBarView(
            dragStartBehavior: DragStartBehavior.down,
            children: <Widget>[
              con.widget.marketTab,
              con.widget.portfolioTab,
            ],
          ),
        ),
      );

  Widget get _degree02 => DefaultTabController(
        length: 2,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: con.scaffoldKey,
          appBar: con.widget.appBar,
          floatingActionButton: con.widget.floatingButton.createCompany,
          drawer: Drawer(
            child: ListView(
              dragStartBehavior: DragStartBehavior.down,
              children: <Widget>[
                const DrawerHeader(child: Center(child: Text('Stocks'))),
                con.widget.stockList,
                con.widget.accountBalance,
                con.widget.dumpConsole,
                const Divider(),
                con.widget.optimistic,
                con.widget.pessimistic,
                const Divider(),
                con.widget.settings,
                con.widget.about,
              ],
            ),
          ),
          body: TabBarView(
            dragStartBehavior: DragStartBehavior.down,
            children: <Widget>[
              con.widget.marketTab,
              con.widget.portfolioTab,
            ],
          ),
        ),
      );

  Widget get _degree03 => DefaultTabController(
        length: 2,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: con.scaffoldKey,
          appBar: con.widget.appBar,
          floatingActionButton: con.widget.floatingButton.createCompany,
          drawer: con.widget.drawer,
          body: con.widget.body,
        ),
      );
}