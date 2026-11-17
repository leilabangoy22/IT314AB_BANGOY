import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_flutter_app/main.dart';

void main() {
  testWidgets('Student List Screen opens', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Student List Screen'), findsOneWidget);
  });
}