import 'package:flutter/material.dart';

class AssetsPage extends StatelessWidget {
  final String unitName;
  const AssetsPage({
    super.key,
    required this.unitName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(unitName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Assets of $unitName'),
          ],
        ),
      ),
    );
  }
}
