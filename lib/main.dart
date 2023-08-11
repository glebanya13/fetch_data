import 'package:fetch_data/model/Product.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Market'),
        ),
        body: CustomScrollView(slivers: [
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            return FutureBuilder<List<Product>>(
                future:
                    fetchProducts('https://ga.com.tm/', '.product-grid-item'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final productList = snapshot.data!;
                    return Column(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 8, left: 20),
                          child: Text(
                            'Новинки',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              wordSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    mainAxisExtent: 290),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              final product = productList[index];
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () => {
                                  //
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Theme.of(context).primaryColor),
                                  child: Column(children: [
                                    Container(
                                      height: 175,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12)),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  product.imageUrl),
                                              fit: BoxFit.cover)),
                                    ),
                                    //title
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5, right: 5),
                                      child: SizedBox(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          product.name,
                                          //phoneDataList[index].name,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            }),
                      ),
                    ]);
                  }
                });
          })),
        ]));
  }
}
