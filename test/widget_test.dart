import 'package:flutter_test/flutter_test.dart';
import 'package:figma_app/main.dart';

void main() {
  testWidgets('App renders HomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify the app renders
    expect(find.text('Figma App'), findsOneWidget);
    expect(find.text('Xin chào! 👋'), findsOneWidget);
  });
}
