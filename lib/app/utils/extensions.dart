extension StringCapitalization on String {
  String toCapitalized() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension DoubleToBR on double {
  String toBRL() {
    String value = toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ $value';
  }
}
