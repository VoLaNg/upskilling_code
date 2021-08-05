class DataSource extends Iterable<int> {
  DataSource(this.items);
  final List<int> items;

  @override
  Iterator<int> get iterator => /* complete the getter */;
}

List<String> mapping(DataSource input) {
  final List<String> result = [];
  final changedData = /* transform int to string according to challenge explanation */;
  changedData.forEach((element) {
    result.add(element);
  });
  return result;
}