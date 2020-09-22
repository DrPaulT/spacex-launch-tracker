import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_launch_tracker/ui/download_error_widget.dart';

void main() {
  testWidgets('Download error widget displayed correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DownloadErrorWidget(),
      ),
    );
    expect(find.text('Download error'), findsOneWidget);
    expect(
      find.text('There was a problem fetching launch information.'),
      findsOneWidget,
    );
    expect(find.text('TRY AGAIN'), findsOneWidget);
  });
}
