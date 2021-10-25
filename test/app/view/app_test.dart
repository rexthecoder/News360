import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news360/src/app/app.dart';
import 'package:news360/src/logic/authentication/export.dart';

class MockAuthController extends Mock implements AuthenticationController {}

class MockAuthService extends Mock implements AuthConfiguration {}

void main() {
  group('App', () {
    testWidgets('renders Onboarding Page', (tester) async {
      await tester.pumpWidget(const App());
    });
  });
}
