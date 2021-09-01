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

class ModelBuilder<T extends Listenable> extends AnimatedWidget {
  final Widget Function(BuildContext, T) builder;

  ModelBuilder({
    Key? key,
    required T model,
    required this.builder,
  }) : super(key: key, listenable: model);

  @override
  Widget build(BuildContext context) {
    return builder(context, listenable as T);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: ExamplePage(
        model: FormModelImpl(
          repository: RepositoryMock(),
        ),
      ),
    );
  }
}
