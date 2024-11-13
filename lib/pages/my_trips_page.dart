import 'package:flutter/material.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Your Trips Overview',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
