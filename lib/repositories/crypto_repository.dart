import 'dart:convert';

import 'package:crypto_app/models/coin_model.dart';
import 'package:crypto_app/models/failure_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoRepository {
  static const String _baseUrl = "https://min-api.cryptocompare.com/";
  static const int perPage = 14;
  final http.Client _httpClient;
  CryptoRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<CoinModel>> getTopCoins({required int page}) async {
    final requestUrl =
        "$_baseUrl" + "data/top/totalvolfull?limit=$perPage&tsym=USD&page=$page";
    try {
      final response = await _httpClient.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response
            .body); // convert string to map string dynamic , body is string
        final coinList = List.from(data["Data"]);
        return coinList.map((e) => CoinModel.fromMap(e)).toList();
      }
      return [];
    } catch (error) {
      print(error);
      throw Failure(message: error.toString());
    }
  }
}
