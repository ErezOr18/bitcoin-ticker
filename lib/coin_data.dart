import 'package:bitcoin_ticker/services/network_helper.dart';

const apiKey = 'E058EED0-9B5A-4FAD-8879-E46D9481C42A';

const apiUrl = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  NetworkHelper networkHelper = NetworkHelper();

  Future<int> getCoinRate(final String currency, final String crypto) async {
    print(apiUrl + '/' + currency);
    try {
      dynamic coinData = await networkHelper.getCoinData(
          apiUrl + '/' + crypto + '/' + currency + '?apikey=$apiKey');

      return coinData['rate'].toInt();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
