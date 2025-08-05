import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/di.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/theme/presentation/bloc/theme.cubit.dart';
import 'package:todo_app/features/task/presentation/bloc/task.bloc.dart';
import 'package:todo_app/features/task/presentation/pages/tasks.page.dart';

void main() {
  setUp(
    () {
      getIt.reset();
      setupDependencies();
    },
  );

  group('TaskFilterChips Widget Tests', () {
    late Widget testWidget;

    setUp(() {
      testWidget = MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ThemeCubit>()),
          BlocProvider(create: (_) => getIt<TaskBloc>()..add(GetTasks())),
        ],
        child: const MyTodoApp(),
      );
    });

    testWidgets('Debería mostrar tres chips: Todas, Pendientes y Completadas',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      expect(find.text('Todas'), findsOneWidget);
      expect(find.text('Pendientes'), findsOneWidget);
      expect(find.text('Completadas'), findsOneWidget);
    });

    testWidgets('Debería resaltar el chip seleccionado con primaryContainer',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      final selectedChip = find.widgetWithText(Chip, 'Pendientes').first;
      final Chip chipWidget = tester.widget(selectedChip);

      expect(
          chipWidget.backgroundColor,
          equals(Theme.of(tester.element(find.text('Pendientes')))
              .colorScheme
              .primaryContainer));
    });

    testWidgets('No debería resaltar los chips no seleccionados',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      final allChip = find.widgetWithText(Chip, 'Todas').first;
      final completedChip = find.widgetWithText(Chip, 'Completadas').first;

      final Chip allChipWidget = tester.widget(allChip);
      final Chip completedChipWidget = tester.widget(completedChip);

      expect(allChipWidget.backgroundColor, isNull);
      expect(completedChipWidget.backgroundColor, isNull);
    });

    testWidgets(
        'Al tocar el chip "Todas", debería actualizar el estado y resaltarlo',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      final allChipKey = find.byKey(ValueKey('chip-${TaskFilter.all}'));
      await tester.tap(allChipKey);
      await tester.pump();

      final selectedChip = find.widgetWithText(Chip, 'Todas').first;
      final Chip chipWidget = tester.widget(selectedChip);

      expect(
          chipWidget.backgroundColor,
          equals(Theme.of(tester.element(find.text('Todas')))
              .colorScheme
              .primaryContainer));
    });
  });
}
