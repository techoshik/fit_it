import 'package:fit_it/fit_it.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FitScaffold(
        appBar: AppBar(
          title: Text('App Bar'),
          centerTitle: true,
        ),
        leftNavigation: Column(
          children: [
            ListTile(
              title: Text('Home'),
            ),
          ],
        ),
        bottomNavigationBar: Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Bottom Nav Bar"),
          ),
        ),
        body: FitLayout(
          desktopLarge: (context) => Text('Desktop Large'),
          desktop: (context) => Text('Desktop'),
          tablet: (context) => Text('tablet'),
          mobile: (context) => Text('mobile'),
          laptop: (context) => Text('laptop'),
        ),
      ),
    );
  }
}
