import 'package:flutter/material.dart';

class BookFlightPage extends StatelessWidget {
  const BookFlightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Book Your Flight Here!',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
