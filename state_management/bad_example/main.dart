import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

abstract class Repository {
  Future<void> submitForm(String text);
}

class ExamplePage extends StatefulWidget {
  final Repository repository;

  const ExamplePage({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  late final _controller = TextEditingController();
  String? _errorHint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  errorText: _errorHint,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onButtonTap,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onButtonTap() async {
    try {
      await widget.repository.submitForm(_controller.text);
      if (mounted) {
        setState(() {
          _errorHint = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorHint = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
