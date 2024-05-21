import 'package:flutter/material.dart';

class GraphsPage extends StatefulWidget {
  const GraphsPage({super.key});

  @override
  State<GraphsPage> createState() => _GraphsPageState();
}

class _GraphsPageState extends State<GraphsPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Text("Notifications"));
  }
}
