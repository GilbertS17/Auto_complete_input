# AutoCompleteInput Flutter Library

A **dynamic, modern, and customizable autocomplete text input** widget for Flutter.  
It supports searching through a `List<Map<dynamic, dynamic>>` with flexible display options, keyboard selection, and scrollable suggestions.

---

## Features

- **Dynamic Input:** Accepts a list of maps as the data source.
- **Custom Search Fields:** Search in specific fields or fallback to a custom display format.
- **Display Customization:** Use `displayBuilder` to define how each item is shown.
- **Keyboard Support:** Press Enter to select the first suggestion automatically.
- **Scrollable Dropdown:** Handles long suggestion lists with a scrollable overlay.
- **Customizable UI:** Colors, text styles, borders, hint text, dropdown max size.
- **Modern Design:** Rounded borders, shadows, and clean layout.

---

## Installation

Add this library to your Flutter project's `pubspec.yaml`:

```yaml
dependencies:
  auto_complete_input:
    path: ../auto_complete_input # adjust path if local
```

Or import directly:
```dart
import 'package:auto_complete_input/auto_complete_input.dart';
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:auto_complete_input/auto_complete_input.dart';

final productsList = [
  { "productID": "P001", "Description": "iPhone 17", "qty": 5, "unitPrice": 920 },
  { "productID": "P002", "Description": "Samsung S26", "qty": 8, "unitPrice": 950 },
  { "productID": "P003", "Description": "Google Pixel 10", "qty": 12, "unitPrice": 899 },
  // ... more products
];

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Map<dynamic, dynamic>? selectedProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AutoCompleteInput(
          data: productsList,
          displayBuilder: (item) => "${item['productID']} (${item['Description']})",
          searchFields: ["productID", "Description"], // optional
          onSelected: (item) {
            setState(() {
              selectedProduct = item;
            });
            print("Selected: $selectedProduct");
          },
          config: AutoCompleteConfig(
            primaryColor: Colors.grey[100],      // input background
            suggestionBgColor: Colors.white,     // dropdown background
            inputStyle: TextStyle(color: Colors.black),
            suggestionTextStyle: TextStyle(color: Colors.black87),
            borderRadius: 10,
            hintText: "Search product ID or name",
            maxWidth: 450,
            maxHeight: 500,
          ),
        ),
      ),
    );
  }
}
```

### `AutoCompleteInput`

| Parameter       | Type                     | Description                                               |
|-----------------|-------------------------|-----------------------------------------------------------|
| `data`          | `List<Map<dynamic,dynamic>>` | Required. The list of items to search.                  |
| `displayBuilder`| `String Function(Map)`   | Required. Builds the string shown in the dropdown and input. |
| `onSelected`    | `Function(Map)`          | Required. Callback when an item is selected.            |
| `searchFields`  | `List<String>?`          | Optional. Fields to search. Defaults to the displayBuilder value. |
| `config`        | `AutoCompleteConfig`     | Optional. Customize colors, text style, hint, and dropdown size. |

---

### `AutoCompleteConfig`

| Parameter            | Type          | Default                | Description                                                     |
|----------------------|---------------|-----------------------|-----------------------------------------------------------------|
| `primaryColor`       | `Color?`      | `null`                | Input background color. Not filled if null.                     |
| `suggestionBgColor`  | `Color`       | `Colors.white`        | Dropdown background color.                                       |
| `inputStyle`          | `TextStyle?`  | null                  | Text style of the input field.                                   |
| `suggestionTextStyle`| `TextStyle?`  | null                  | Text style of suggestions.                                       |
| `hintText`           | `String?`     | `"Search..."`         | Placeholder text in the input.                                   |
| `borderRadius`       | `double`      | `12`                  | Rounded corners for input and dropdown.                          |
| `maxWidth`           | `double`      | `double.infinity`     | Maximum width of the dropdown.                                    |
| `maxHeight`          | `double`      | `250`                 | Maximum height of the dropdown; scrollable if exceeded.          |



## License

MIT License
