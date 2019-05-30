// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:timeswap/main.dart';

void main() {

  test('login config test', () async {
    String config = await rootBundle.loadString('config/login/animation.json');
    assert(config != null && config.isNotEmpty);
  });
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // TODO Implement
  });
}
