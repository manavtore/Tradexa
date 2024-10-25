import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradexa/data_layer/providers/movieprovider.dart';
import 'presentation/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider()),
      ],

      child: MaterialApp(
        title: 'Movie Search App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
