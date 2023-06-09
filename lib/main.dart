/*
import 'package:flutter/material.dart';
import 'package:hello_world/native.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FutureBuilder(
              future: api.helloWorld(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('The Rust function calling: ${snapshot.data}');
                }
              },
            ),
            FutureBuilder(
              future: Future(() {
                return api.sum(a: 100, b: 3);
              }),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int result = snapshot.data ?? 0;
                  return Text('Result: $result');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
            ElevatedButton(
              onPressed: () async {
                String? encrypted = await api.encrypt(
                  x: 'Hello World',
                  k: 'magickey',
                );
                if (encrypted != null) {
                  String encryptedValue = encrypted!;
                  // Tiếp tục xử lý với giá trị encryptedValue
                  print('encryptedValue: $encryptedValue');
                } else {
                  // Xử lý khi giá trị encrypted là null
                  print('encryptedValue: empty');
                }
              },
              child: Text('Encrypt'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:hello_world/native.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController();
  String _encryptedValue = '';

  Future<void> _encryptValue() async {
    String inputValue = _inputController.text;
    String? encryptedValue = await api.encrypt(
      x: inputValue,
      k: 'magickey',
    );

    setState(() {
      _encryptedValue = encryptedValue ?? 'Encryption failed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Rust Bridge"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter a value to encrypt',
              ),
            ),
            ElevatedButton(
              onPressed: _encryptValue,
              child: const Text('Encrypt'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Encrypted value: $_encryptedValue',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:hello_world/native.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Rust Bridge',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _encryptKeyController = TextEditingController();
  final TextEditingController _decryptKeyController = TextEditingController();
  String _encryptedValue = '';
  String _decryptedValue = '';

  Future<void> _encryptValue() async {
    String inputValue = _inputController.text;
    String? encryptedValue = await api.encrypt(
      x: inputValue,
      k: _encryptKeyController.text,
    );

    setState(() {
      _encryptedValue = encryptedValue ?? 'Encryption failed';
      _decryptedValue = ''; // Reset decrypted value
    });
  }

  Future<void> _decryptValue() async {
    String? decryptedValue = await api.decrypt(
      x: _encryptedValue,
      k: _decryptKeyController.text,
    );

    setState(() {
      _decryptedValue = decryptedValue ?? 'Decryption failed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Rust Bridge"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter a value to encrypt',
              ),
            ),
            TextField(
              controller: _encryptKeyController,
              decoration: const InputDecoration(
                labelText: 'Enter the encryption key',
              ),
            ),
            ElevatedButton(
              onPressed: _encryptValue,
              child: const Text('Encrypt'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _decryptKeyController,
              decoration: const InputDecoration(
                labelText: 'Enter the decryption key',
              ),
            ),
            ElevatedButton(
              onPressed: _decryptValue,
              child: const Text('Decrypt'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Encrypted value: $_encryptedValue',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              'Decrypted value: $_decryptedValue',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
