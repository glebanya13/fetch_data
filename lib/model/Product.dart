import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class Product {
  String name;
  String model;
  String description;
  String imageUrl;

  Product({
    required this.name,
    required this.model,
    required this.description,
    required this.imageUrl,
  });
}

Future<List<Product>> fetchProducts(String url, String cardWithDot) async {
  List<Product> productList = [];
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final cards = document.querySelectorAll(cardWithDot);

      for (final card in cards) {
        final name = card.querySelector('.wd-entities-title')?.text ?? '';
        final model = card.querySelector('.price')?.text ?? '';
        final description =
            card.querySelector('.phone-description')?.text ?? '';
        final imageElement = card.querySelector('.product-image-link img');
        final imageUrl = imageElement?.attributes['data-src'] ?? '';

        final product = Product(
          name: name,
          model: model,
          description: description,
          imageUrl: imageUrl,
        );
        productList.add(product);
      }
    }
  } catch (e) {
    // Handle error
    print('Error $e');
  }
  return productList;
}
