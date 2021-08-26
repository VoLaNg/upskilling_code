void main() {
  runApp(MyApp());
}

class RepositoryMock implements Repository {
  Future<void> submitForm(String text) async {
    if (text.isEmpty) {
      throw Exception('Text is empty');
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: ExamplePage(repository: RepositoryMock()),
    );
  }
}
