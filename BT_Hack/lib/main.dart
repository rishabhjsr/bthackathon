import 'package:bt_hack/features/details/presentation/pages/product_page.dart';
import 'package:bt_hack/features/home/presentation/pages/home_page.dart';
import 'package:bt_hack/features/search/presentation/pages/searchResult_page.dart';
import 'package:flutter/material.dart';

import 'core/models/product_model.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Product products=Product(category: "",title: "",id: 0,image: "",price: 0.0,description: "",rating:Rating(rate: 0.0, count: 0) );
    String query='';
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        ProductPage.id:(context)=> ProductPage(product:products),
        SearchPage.id:(context)=> SearchPage(query: query,),
      },
    );
  }
}

