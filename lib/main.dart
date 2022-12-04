import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

final names = [
  'John',
  'Aslam',
  'Amran',
  'Tuhin',
  'Ambani',
  'Ashraf',
  'Probir',
];

final counterProvider = StreamProvider(
    (ref) => Stream.periodic(const Duration(seconds: 1), (i) => i++));

final namesProvider = StreamProvider((ref) =>
    ref.watch(counterProvider.stream).map((count) => names.getRange(0, count)));

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namesPro = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamProvider'),
      ),
      body: namesPro.when(
        data: (dataNames) {
          return ListView.builder(
            itemCount: dataNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataNames.elementAt(index)),
              );
            },
          );
        },
        error: ((error, stackTrace) => Text('Names length exceeds')),
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
