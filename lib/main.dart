import 'package:coffe_app/src/repositories/coffeee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/bloc/coffee_bloc.dart';
import 'src/pages/home_page.dart';
import 'src/pages/image_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CoffeeRepository coffeeRepository = CoffeeRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CoffeeBloc>(
          create: (BuildContext context) => CoffeeBloc(coffeeRepository: coffeeRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Coffee App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'single_image': (context) => SingleImagePage(),
        },
      ),
    );
  }
}
