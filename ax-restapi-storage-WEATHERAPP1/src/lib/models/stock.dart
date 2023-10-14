class Stock {
  String symbol;
  String name;
  //num type can be an integer or a double.
  num price;

  Stock({required this.symbol, required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'name': name,
      'price': price,
    };
  }
}
