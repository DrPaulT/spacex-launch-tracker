import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_launch_tracker/ui/waiting_widget.dart';

void main() {
  testWidgets('Waiting widget shows a spinner', (WidgetTester tester) async {
    await tester.pumpWidget(WaitingWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
