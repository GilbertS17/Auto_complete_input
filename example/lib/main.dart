import 'package:flutter/material.dart';
import 'package:cgc_auto_complete/cgc_auto_complete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<dynamic, dynamic>? selectedProduct;

  @override
  Widget build(BuildContext context) {

    final productsList = [
      { "productID": "P001", "Description": "iPhone 17", "qty": 5, "unitPrice": 920 },
      { "productID": "P002", "Description": "Samsung S26", "qty": 8, "unitPrice": 950 },
      { "productID": "P003", "Description": "Google Pixel 10", "qty": 12, "unitPrice": 899 },
      { "productID": "P004", "Description": "MacBook Air M4", "qty": 4, "unitPrice": 1199 },
      { "productID": "P005", "Description": "Dell XPS 13", "qty": 6, "unitPrice": 1050 },
      { "productID": "P006", "Description": "Sony WH-1000XM6", "qty": 15, "unitPrice": 349 },
      { "productID": "P007", "Description": "Apple Watch Ultra 3", "qty": 10, "unitPrice": 799 },
      { "productID": "P008", "Description": "Nintendo Switch Pro", "qty": 20, "unitPrice": 399 },
      { "productID": "P009", "Description": "iPad Pro M3", "qty": 7, "unitPrice": 999 },
      { "productID": "P010", "Description": "AirPods Pro 3", "qty": 25, "unitPrice": 249 },
      { "productID": "P011", "Description": "Logitech MX Master 4", "qty": 30, "unitPrice": 99 },
      { "productID": "P012", "Description": "ASUS ROG Zephyrus", "qty": 3, "unitPrice": 1850 },
      { "productID": "P013", "Description": "GoPro Hero 13", "qty": 14, "unitPrice": 420 },
      { "productID": "P014", "Description": "Kindle Paperwhite 6", "qty": 18, "unitPrice": 149 },
      { "productID": "P015", "Description": "Samsung T9 SSD 2TB", "qty": 22, "unitPrice": 180 },
      { "productID": "P016", "Description": "Sony PlayStation 6", "qty": 2, "unitPrice": 599 },
      { "productID": "P017", "Description": "LG C4 OLED 55in", "qty": 5, "unitPrice": 1399 },
      { "productID": "P018", "Description": "NVIDIA RTX 5080", "qty": 4, "unitPrice": 1199 },
      { "productID": "P019", "Description": "Bose QuietComfort Ultra", "qty": 11, "unitPrice": 429 },
      { "productID": "P020", "Description": "Razer BlackWidow V5", "qty": 9, "unitPrice": 169 },
      { "productID": "P021", "Description": "Microsoft Surface Pro 11", "qty": 6, "unitPrice": 1099 },
      { "productID": "P022", "Description": "DJI Mini 5 Pro", "qty": 8, "unitPrice": 759 },
      { "productID": "P023", "Description": "Sonos Era 300", "qty": 13, "unitPrice": 449 },
      { "productID": "P024", "Description": "Keychron Q3 Pro", "qty": 10, "unitPrice": 189 },
      { "productID": "P025", "Description": "Samsung Galaxy Watch 7", "qty": 16, "unitPrice": 329 },
      { "productID": "P026", "Description": "Seagate IronWolf 8TB", "qty": 12, "unitPrice": 210 },
      { "productID": "P027", "Description": "SteelSeries Arctis Nova", "qty": 20, "unitPrice": 199 },
      { "productID": "P028", "Description": "HP Spectre x360", "qty": 5, "unitPrice": 1250 },
      { "productID": "P029", "Description": "Beats Studio Buds+", "qty": 18, "unitPrice": 169 },
      { "productID": "P030", "Description": "Anker 737 PowerBank", "qty": 40, "unitPrice": 140 }
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: AutoCompleteInput(
            displayBuilder: (item) =>
                "${item['productID']} (${item['Description']})",
          onSelected: (product) {
              selectedProduct = product;
          },
          data: productsList,
          config: AutoCompleteConfig(
            maxWidth: 300,
            maxHeight: 50,
            suggestionMaxHeight: 300,
            icon: Icon(Icons.search, color: Colors.indigo,)
          ),
        )
      ),
    );
  }
}
