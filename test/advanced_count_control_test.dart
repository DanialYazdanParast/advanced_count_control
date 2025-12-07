import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_count_control/advanced_count_control.dart';

void main() {
  group('AdvancedCountControl Widget Tests', () {
    testWidgets('Displays Add Button when quantity is 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdvancedCountControl(
              currentQuantity: 0,
              onIncrease: () {},
              onDecrease: () {},
            ),
          ),
        ),
      );

      // بررسی وجود دکمه افزودن
      expect(find.byKey(const ValueKey('addButton')), findsOneWidget);
      expect(find.text('افزودن به سبد خرید'), findsOneWidget);
      expect(find.byKey(const ValueKey('counterControl')), findsNothing);
    });

    testWidgets('Displays Counter when quantity is > 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdvancedCountControl(
              currentQuantity: 1,
              onIncrease: () {},
              onDecrease: () {},
            ),
          ),
        ),
      );

      // بررسی وجود کانتر
      expect(find.byKey(const ValueKey('counterControl')), findsOneWidget);
      expect(find.text('1'), findsOneWidget); // نمایش عدد ۱
      expect(find.byKey(const ValueKey('addButton')), findsNothing);
    });

    testWidgets('Calls onIncrease when Add Button is tapped', (WidgetTester tester) async {
      bool isIncreased = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdvancedCountControl(
              currentQuantity: 0,
              onIncrease: () {
                isIncreased = true;
              },
              onDecrease: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('addButton')));
      expect(isIncreased, isTrue);
    });

    testWidgets('Shows delete icon when quantity is 1', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdvancedCountControl(
              currentQuantity: 1,
              onIncrease: () {},
              onDecrease: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.delete_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsNothing);
    });

    testWidgets('Disabled state disables interactions', (WidgetTester tester) async {
      bool isTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdvancedCountControl(
              currentQuantity: 0,
              isDisabled: true,
              onIncrease: () {
                isTapped = true;
              },
              onDecrease: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('addButton')));
      expect(isTapped, isFalse);
    });
  });
}