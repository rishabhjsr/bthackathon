import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class SearchApiService
{

  // final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Product>> getProduct(String query) async{
    try{
      final String url = 'http://127.0.0.1:8000/$query';
      final response = await http.get(Uri.parse(url));
      // print(response.body);
      if(response.statusCode==200)
      {
        List<dynamic> jsonResponse=jsonDecode(response.body)['data'];
        // print(jsonResponse);
        print("********************************************");
        List<Product> products=jsonResponse.map((dynamic item) => Product.fromJson(item)).toList();
        return products;
      }
      else
      {
        print("response code is not 200");
        print(response.statusCode);
        throw("couldn't fetch the products");
      }
    }
    catch(exception){
      print(exception);

      print("Error during fetching response from api check ApiService class!!");

    }
    return [];
  }
}