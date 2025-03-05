import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';
import 'package:music_learning_app/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_state.dart';

class MockThemeCubit extends Mock implements ThemeCubit {}

class MockDashboardCubit extends Mock implements DashboardCubit {}

void main() {
  late MockThemeCubit themeCubit;
  late MockDashboardCubit dashboardCubit;

  setUp(() {
    themeCubit = MockThemeCubit();
    dashboardCubit = MockDashboardCubit();
  });

  Widget createTestableWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: themeCubit),
        BlocProvider<DashboardCubit>.value(value: dashboardCubit),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('DashboardView displays correctly', (WidgetTester tester) async {
    final themeData = ThemeData.light();
    final state = DashboardState(selectedIndex: 0, views: [Container()]);

    when(() => themeCubit.state).thenReturn(themeData);
    when(() => dashboardCubit.state).thenReturn(state);

    await tester.pumpWidget(createTestableWidget(DashboardView()));

    expect(find.text('Melody Mentor'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('Tapping on BottomNavigationBar changes the tab',
      (WidgetTester tester) async {
    final themeData = ThemeData.light();
    final state =
        DashboardState(selectedIndex: 0, views: [Container(), Container()]);

    when(() => themeCubit.state).thenReturn(themeData);
    when(() => dashboardCubit.state).thenReturn(state);
    when(() => dashboardCubit.onTabTapped(any())).thenAnswer((_) {});

    await tester.pumpWidget(createTestableWidget(DashboardView()));

    await tester.tap(find.byIcon(Icons.music_note));
    await tester.pump();

    verify(() => dashboardCubit.onTabTapped(1)).called(1);
  });
}
