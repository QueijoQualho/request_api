import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dio dio = Dio();
  List<dynamic> products = [];

  Future<void> fetchProducts() async {
    try {
      Response response = await dio.get('https://fakestoreapi.com/products/');
      setState(() {
        products = response.data;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchProducts,
              child: Text('Fetch Products'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(products[index]['title']),
                    subtitle: Text('\$${products[index]['price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
