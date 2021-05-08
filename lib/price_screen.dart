import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  String rate = '?';
  Map<String, String> rates =
      Map.fromIterable(cryptoList, key: (e) => e, value: (e) => '?');

  @override
  void initState() {
    super.initState();
    getCoinData();
  }

  void getCoinData() async {
    for (String crypto in cryptoList) {
      int intRate = await coinData.getCoinRate(selectedCurrency, crypto);
      rates[crypto] = intRate.toString();
    }
    setState(() {
      rates = rates;
    });
  }

  DropdownButton getDropdownButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList.map((e) {
        return DropdownMenuItem(
          child: Text(e),
          value: e,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getCoinData();
      },
    );
  }

  cupertino.CupertinoPicker getCupertinoPicker() {
    return cupertino.CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        getCoinData();
      },
      children: currenciesList.map((e) => Text(e)).toList(),
      backgroundColor: Colors.lightBlue,
    );
  }

  List<Widget> getCard() {
    return cryptoList.map((e) {
      return Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $e = ${rates[e]} $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: cupertino.CrossAxisAlignment.stretch,
            children: getCard(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
