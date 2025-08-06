import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/task/presentation/widgets/preview_statistics_info.widget.dart';

void main() {
  group('PreviewStatisticsInfo Widget Tests', () {
    testWidgets('Muestra correctamente 0% cuando no hay tareas',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PreviewStatisticsInfo(totalTasks: 0, completedTasks: 0),
          ),
        ),
      );

      expect(find.text('0 %'), findsOneWidget);
      expect(find.textContaining('Completadas'), findsNothing);
      expect(find.textContaining('Pendientes'), findsNothing);
    });

    testWidgets('Muestra correctamente 100% cuando todas están completadas',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PreviewStatisticsInfo(totalTasks: 10, completedTasks: 10),
          ),
        ),
      );

      expect(find.text('100 %'), findsOneWidget);
      expect(find.text('Completadas (10)'), findsOneWidget);
      expect(find.textContaining('Pendientes'), findsNothing);
    });

    testWidgets('Muestra correctamente cuando hay tareas pendientes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PreviewStatisticsInfo(totalTasks: 10, completedTasks: 4),
          ),
        ),
      );

      expect(find.text('40 %'), findsOneWidget);
      expect(find.text('Completadas (4)'), findsOneWidget);
      expect(find.text('Pendientes (6)'), findsOneWidget);
    });

    testWidgets('Muestra correctamente cuando no hay tareas completadas',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PreviewStatisticsInfo(totalTasks: 5, completedTasks: 0),
          ),
        ),
      );

      expect(find.text('0 %'), findsOneWidget);
      expect(find.textContaining('Completadas'), findsNothing);
      expect(find.text('Pendientes (5)'), findsOneWidget);
    });

    testWidgets('El LinearProgressIndicator refleja el porcentaje correcto',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PreviewStatisticsInfo(totalTasks: 10, completedTasks: 7),
          ),
        ),
      );

      final progressFinder = find.byType(LinearProgressIndicator);
      expect(progressFinder, findsOneWidget);

      final LinearProgressIndicator progress =
          tester.widget(progressFinder) as LinearProgressIndicator;

      expect(progress.value, equals(0.7));
    });
  });
}
