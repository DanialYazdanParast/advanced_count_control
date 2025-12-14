# Advanced Count Control 🛒

A highly customizable and advanced counter widget for Flutter, designed specifically for e-commerce applications (similar to Digikala style).
<<<<<<< Updated upstream

It automatically handles various states like **"Add to Cart" button**, **Counter**, **Loading**, **Disabled**, and **Trash (Delete)** mode.

<img src="https://github.com/user-attachments/assets/be57a904-5382-43f3-9454-9a69d30ed7fd" alt="Demo Banner" width="200">

=======
# Advanced Count Control 🛒

A highly customizable and advanced counter widget for Flutter, designed specifically for e-commerce applications (similar to Digikala style).

It automatically handles various states like **"Add to Cart" button**, **Counter**, **Loading**, **Disabled**, and **Trash (Delete)** mode.

![Demo Banner](https://via.placeholder.com/800x400?text=Advanced+Count+Control+Demo)
>>>>>>> Stashed changes

## ✨ Features

- 🎨 **Fully Customizable:** Change colors, borders, shadows, fonts, and sizes via `CountControlStyle`.
- 🔄 **Dual Mode:** Automatically switches between a big "Add Button" and the "Counter".
- 🗑️ **Smart Delete:** Shows a trash icon instead of minus when quantity is 1.
- ⏳ **Loading Support:** Shows a loading spinner on the button during async operations (API calls).
- 🚫 **Disabled State:** Disables user interaction visually and functionally (e.g., Out of Stock).
- 🔢 **Number Formatting:** Supports custom number formatters (e.g., Persian numbers).
- 🖼️ **Custom Icons:** Override default icons (Add, Remove, Trash) with your own.

## 📦 Installation

Since this package is hosted on GitHub, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  advanced_count_control:
    git:
      url: https://github.com/DanialYazdanParast/advanced_count_control.git
      ref: main
```

Then run:

```bash
flutter pub get
```

## 🚀 Usage

Basic usage requires `currentQuantity`, `onIncrease`, and `onDecrease`.

```dart
import 'package:flutter/material.dart';
import 'package:advanced_count_control/advanced_count_control.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int quantity = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AdvancedCountControl(
          currentQuantity: quantity,
          isLoading: isLoading,
          
          // Action: Increase (e.g., Call API)
          onIncrease: () async {
            setState(() => isLoading = true);
            await Future.delayed(const Duration(seconds: 1)); // Simulate API
            if (mounted) {
              setState(() {
                quantity++;
                isLoading = false;
              });
            }
          },

          // Action: Decrease
          onDecrease: () {
            setState(() => quantity--);
          },
          
          // Optional: Custom Style
          style: const CountControlStyle(
            primaryColor: Colors.deepPurple,
            borderRadius: 12,
          ),
        ),
      ),
    );
  }
}
```

## ⚙️ Customization

### 1. Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `currentQuantity` | `int` | Required | The current number to display. |
| `onIncrease` | `VoidCallback` | Required | Triggered when (+) or Add button is tapped. |
| `onDecrease` | `VoidCallback` | Required | Triggered when (-) or Trash button is tapped. |
| `maxQuantity` | `int` | 999 | The maximum allowed quantity. |
| `isLoading` | `bool` | false | Shows a loading indicator instead of icons/text. |
| `isDisabled` | `bool` | false | Disables interactions and greys out the widget. |
| `showAddButton` | `bool` | true | Shows a big button when quantity is 0. |
| `addButtonLabel` | `String` | "Add to Cart" | Label for the add button. |
| `maxReachedLabel` | `String` | "Max" | Label shown when max quantity is reached. |
| `iconAdd` | `IconData` | Icons.add | Custom icon for increase button. |
| `iconRemove` | `IconData` | Icons.remove | Custom icon for decrease button. |
| `iconTrash` | `IconData` | Icons.delete | Custom icon for delete action (at qty 1). |

### 2. Styling (CountControlStyle)

You can pass a `CountControlStyle` object to the `style` property to customize the look and feel.

```dart
AdvancedCountControl(
  // ...
  style: CountControlStyle(
    primaryColor: Color(0xFFEF394E), // Main color (e.g., Red)
    backgroundColor: Colors.white,   // Background of the counter
    contentColor: Color(0xFFEF394E), // Icon and Text color
    disabledColor: Colors.grey,      // Color when disabled
    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    btnTextStyle: TextStyle(fontSize: 14, color: Colors.white),
    borderRadius: 8.0,
    borderSide: BorderSide(color: Colors.grey.shade300),
    shadows: [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
    ],
  ),
)
```

<<<<<<< Updated upstream
=======
## 📸 Screenshots

| Standard State | Custom Style | Disabled State |
|----------------|--------------|----------------|
| | | |

>>>>>>> Stashed changes
## ❤️ Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

<<<<<<< Updated upstream
Developed with ❤️ by **Danial YazdanParast**
=======
Developed with ❤️ by **Danial YazdanParast**
>>>>>>> Stashed changes
