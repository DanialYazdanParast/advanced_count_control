import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_count_control/advanced_count_control.dart';

void main() {
  Widget createWidget({
    int currentQuantity = 0,
    int maxQuantity = 10,
    bool isLoading = false,
    bool isDisabled = false,
    VoidCallback? onIncrease,
    VoidCallback? onDecrease,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: AdvancedCountControl(
          currentQuantity: currentQuantity,
          maxQuantity: maxQuantity,
          isLoading: isLoading,
          isDisabled: isDisabled,
          onIncrease: onIncrease ?? () {},
          onDecrease: onDecrease ?? () {},
        ),
      ),
    );
  }

  group('AdvancedCountControl Tests', () {
    // 1. Test for Assertion Error (maxQuantity >= currentQuantity)
    testWidgets('throws assertion error if currentQuantity > maxQuantity',
            (WidgetTester tester) async {
          expect(
                () => createWidget(currentQuantity: 11, maxQuantity: 10),
            throwsAssertionError,
          );
        });

    // 2. Test Basic Rendering (Add Button Mode)
    testWidgets('shows Add Button when quantity is 0', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(currentQuantity: 0));

      expect(find.byKey(const ValueKey('addButton')), findsOneWidget);
      expect(find.text('افزودن به سبد خرید'), findsOneWidget);
      expect(find.byKey(const ValueKey('counterControl')), findsNothing);
    });

    // 3. Test Basic Rendering (Counter Mode)
    testWidgets('shows Counter Control when quantity > 0', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(currentQuantity: 1));

      expect(find.byKey(const ValueKey('counterControl')), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.byKey(const ValueKey('addButton')), findsNothing);
    });

    // 4. Test Increment Action
    testWidgets('calls onIncrease when increment button is tapped', (WidgetTester tester) async {
      bool increaseCalled = false;
      await tester.pumpWidget(createWidget(
        currentQuantity: 1,
        onIncrease: () => increaseCalled = true,
      ));

      await tester.tap(find.byKey(const ValueKey('increaseButton')));
      expect(increaseCalled, isTrue);
    });

    // 5. Test Decrement Action
    testWidgets('calls onDecrease when decrement button is tapped', (WidgetTester tester) async {
      bool decreaseCalled = false;
      await tester.pumpWidget(createWidget(
        currentQuantity: 2,
        onDecrease: () => decreaseCalled = true,
      ));

      await tester.tap(find.byKey(const ValueKey('decreaseButton')));
      expect(decreaseCalled, isTrue);
    });

    // 6. Test Loading State
    testWidgets('shows CircularProgressIndicator when isLoading is true', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(currentQuantity: 0, isLoading: true));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('افزودن به سبد خرید'), findsNothing);
    });

    // 7. Test Disabled State
    testWidgets('buttons are disabled when isDisabled is true', (WidgetTester tester) async {
      bool increaseCalled = false;
      bool decreaseCalled = false;

      await tester.pumpWidget(createWidget(
        currentQuantity: 5,
        isDisabled: true,
        onIncrease: () => increaseCalled = true,
        onDecrease: () => decreaseCalled = true,
      ));

      // Try tapping increment
      await tester.tap(find.byKey(const ValueKey('increaseButton')));
      // Try tapping decrement
      await tester.tap(find.byKey(const ValueKey('decreaseButton')));

      expect(increaseCalled, isFalse);
      expect(decreaseCalled, isFalse);
    });

    // 8. Test Max Quantity Reached UI
    testWidgets('shows max reached label and disables increase button when max reached',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidget(currentQuantity: 5, maxQuantity: 5));

          // Check for label
          expect(find.text('حداکثر'), findsOneWidget);

          // Verify increase callback is not fired
          bool increaseCalled = false;
          // Re-pump with callback to test tap
          await tester.pumpWidget(createWidget(
            currentQuantity: 5,
            maxQuantity: 5,
            onIncrease: () => increaseCalled = true,
          ));

          await tester.tap(find.byKey(const ValueKey('increaseButton')));
          expect(increaseCalled, isFalse);
        });

    // 9. Test Trash Icon Logic
    testWidgets('shows trash icon when quantity is 1', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(currentQuantity: 1));
      expect(find.byIcon(Icons.delete_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsNothing);
    });

    testWidgets('shows remove icon when quantity > 1', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(currentQuantity: 2));
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline_rounded), findsNothing);
    });
  });
}