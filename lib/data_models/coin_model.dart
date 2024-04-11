class Coin {
  String name;
  String symbol;
  String imageURL;
  num price;
  num change;
  num changePercentage;

  Coin({
    required this.name,
    required this.symbol,
    required this.imageURL,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      imageURL: json['image'],
      price: json['current_price'],
      change: json['price_change_24h'],
      changePercentage: json['price_change_percentage_24h']
    );
  }
}

List<Coin> coinList = [];