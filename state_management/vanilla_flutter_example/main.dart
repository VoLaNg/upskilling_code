import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

abstract class Repository {
  Future<void> submitForm(String text);
}

abstract class FormModel extends ChangeNotifier {
  String get text;
  String? get errorHint;

  void onSubmitButtonTap();
  void onTextFieldValueChanged(String newValue);
}

class FormModelImpl extends FormModel {
  final Repository repository;
  FormModelImpl({required this.repository});

  String _text = '';
  String get text => _text;

  String? _errorHint;
  String? get errorHint => _errorHint;
  set errorHint(String? value) {
    _errorHint = value;
    notifyListeners();
  }

  void onTextFieldValueChanged(String newValue) {
    _text = newValue;
  }

  @override
  void onSubmitButtonTap() async {
    try {
      await repository.submitForm(text);
      errorHint = null;
    } catch (e) {
      errorHint = e.toString();
    }
  }
}

class ExamplePage extends StatefulWidget {
  final FormModel model;

  const ExamplePage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ModelBuilder<FormModel>(
                model: widget.model,
                builder: (context, model) {
                  return TextField(
                    onChanged: model.onTextFieldValueChanged,
                    decoration: InputDecoration(
                      errorText: model.errorHint,
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: widget.model.onSubmitButtonTap,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
