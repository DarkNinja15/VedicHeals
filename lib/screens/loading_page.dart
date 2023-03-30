import 'package:flutter/material.dart';
import 'package:vedic_heals/widgets/loading.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.tealAccent,
      body: Center(
        child: Loading(),
      ),
    );
  }
}
