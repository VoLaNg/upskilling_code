typedef TestFunction = List<String> Function(List<int>);

void main() {
  final testMap = {
    DataSource([1, 2, 3, 4]): ['item 1', 'item 2', 'item 3', 'item 4'],
    DataSource([100, 1002, 300, 4]): ['item 100', 'item 1002', 'item 300', 'item 4'],
  };

  _test(testMap, mapping);
}

void _test(Map testMap, TestFunction f) {
  for (final entry in testMap.entries) {
    final result = _expect(entry.key, entry.value, f(entry.key));
    if (result != null) {
      _result(false, result);
      return;
    }
  }

  _result(true);
}

List<String>? _expect(given, expected, actual) {
  if (actual == expected) {
    return null;
  } else {
    return [
      'Test failed.',
      '',
      'Given: $given',
      'Expected: $expected',
      'Actual: $actual'
    ];
  }
}
