import 'package:flutter/material.dart';

class ViewInvoicesScreen extends StatelessWidget {
  const ViewInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Invoice"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: TextField()),
                ElevatedButton(onPressed: (){}, child: const Text("View"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
