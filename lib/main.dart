import 'package:flutter/material.dart';
import 'package:indicadores_desenvolvimento/browser_service.dart';
import 'package:indicadores_desenvolvimento/repositories/configuration_repository.dart';
import 'package:puppeteer/puppeteer.dart';

void main() async {
  await ConfigurationRepository.loadEnvFile();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Indicadores desenvolvimento'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _test,
          child: const Text('teste'),
        ),
      ),
    );
  }

  Future _test() async {
    // final service = BrowserService();
    // await service.getInformationFromPage('https://mercatustecnologia.atlassian.net/issues/?filter=10361');
    BrowserHandle().handle('https://mercatustecnologia.atlassian.net/issues/?filter=10361');
  }
}
