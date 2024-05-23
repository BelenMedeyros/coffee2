import 'package:coffe_app/src/bloc/coffee_bloc.dart';
import 'package:coffe_app/src/repositories/coffeee_repository.dart';
import 'package:coffe_app/src/widgets/coffee_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coffe_app/src/pages/home_page.dart';


void main() {
  testWidgets('HomePage UI Test', (WidgetTester tester) async {
    final coffeeBloc = CoffeeBloc(coffeeRepository: CoffeeRepository());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: coffeeBloc,
          child: const HomePage(),
        ),
      ),
    );

    expect(find.text('Coffee App'), findsOneWidget);
    expect(find.byType(CoffeeGrid), findsOneWidget);
  });
}
