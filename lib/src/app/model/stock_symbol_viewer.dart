// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:stocks/src/app/model/stock_arrow.dart';
import 'package:stocks/src/app/model/stock_data.dart';

///
class StockSymbolPage extends StatelessWidget {
  ///
  const StockSymbolPage(
      {super.key, required this.symbol, required this.stocks});

  ///
  final String symbol;

  ///
  final StockData stocks;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: stocks,
      builder: (BuildContext context, Widget? child) {
        final Stock? stock = stocks[symbol];
        return Scaffold(
          appBar: AppBar(
            title: Text(stock?.name ?? symbol),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Card(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  firstChild: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  secondChild: stock != null
                      ? _StockSymbolView(
                          stock: stock,
                          arrow: Hero(
                            tag: stock,
                            child:
                                StockArrow(percentChange: stock.percentChange),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(child: Text('$symbol not found')),
                        ),
                  crossFadeState: stock == null && stocks.loading
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

///
class StockSymbolBottomSheet extends StatelessWidget {
  ///
  const StockSymbolBottomSheet({super.key, required this.stock});

  ///
  final Stock stock;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black26))),
      child: _StockSymbolView(
        stock: stock,
        arrow: StockArrow(percentChange: stock.percentChange),
      ),
    );
  }
}

class _StockSymbolView extends StatelessWidget {
  const _StockSymbolView({required this.stock, required this.arrow});

  final Stock stock;
  final Widget arrow;

  @override
  Widget build(BuildContext context) {
    final String lastSale = '\$${stock.lastSale.toStringAsFixed(2)}';
    String changeInPrice = '${stock.percentChange.toStringAsFixed(2)}%';
    if (stock.percentChange > 0) {
      changeInPrice = '+$changeInPrice';
    }

    final TextStyle headings = Theme.of(context).textTheme.bodyLarge!;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                stock.symbol,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              arrow,
            ],
          ),
          Text('Last Sale', style: headings),
          Text('$lastSale ($changeInPrice)'),
          Container(height: 8),
          Text('Market Cap', style: headings),
          Text(stock.marketCap),
          Container(height: 8),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .merge(const TextStyle(fontSize: 8)),
              text: 'Prices may be delayed by ',
              children: const <TextSpan>[
                TextSpan(
                    text: 'several',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(text: ' years.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
