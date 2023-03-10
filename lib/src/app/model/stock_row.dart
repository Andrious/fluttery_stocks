// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:stocks/src/app/model/stock_arrow.dart';
import 'package:stocks/src/app/model/stock_data.dart';

///
typedef StockRowActionCallback = void Function(Stock stock);

///
class StockRow extends StatelessWidget {
  ///
  StockRow({
    required this.stock,
    required this.onPressed,
    required this.onDoubleTap,
    required this.onLongPressed,
  }) : super(key: ObjectKey(stock));

  ///
  final Stock stock;

  ///
  final StockRowActionCallback onPressed;

  ///
  final StockRowActionCallback onDoubleTap;

  ///
  final StockRowActionCallback onLongPressed;

  ///
  static const double kHeight = 79;

  GestureTapCallback? _getHandler(StockRowActionCallback? callback) {
    return callback == null ? null : () => callback(stock);
  }

  @override
  Widget build(BuildContext context) {
    final String lastSale = '\$${stock.lastSale.toStringAsFixed(2)}';
    String changeInPrice = '${stock.percentChange.toStringAsFixed(2)}%';
    if (stock.percentChange > 0) {
      changeInPrice = '+$changeInPrice';
    }
    return InkWell(
      onTap: _getHandler(onPressed),
      onDoubleTap: _getHandler(onDoubleTap),
      onLongPress: _getHandler(onLongPressed),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor))),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Hero(
                tag: stock,
                child: StockArrow(percentChange: stock.percentChange),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: DefaultTextStyle.of(context).style.textBaseline,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(stock.symbol),
                  ),
                  Expanded(
                    child: Text(
                      lastSale,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      changeInPrice,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
