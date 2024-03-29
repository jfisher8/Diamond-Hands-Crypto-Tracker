class Exchanges {
  late String name;
  late int yearEstablished;
  late String url;
  late String image;

  Exchanges({
    required this.name, required this.yearEstablished, required this.url, required this.image
  });

  Exchanges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    yearEstablished = json['year_established'];
    url = json['url'];
    image = json['image'];
  }
}

List<Exchanges> exchangesList = [];