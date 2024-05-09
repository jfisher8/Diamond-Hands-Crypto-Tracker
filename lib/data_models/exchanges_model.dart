class Exchanges {
  late String name;
  late int? yearEstablished;
  late String url;
  late String imageURL;

  Exchanges({
    required this.name, required this.yearEstablished, required this.url, required this.imageURL
  });

  Exchanges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    yearEstablished = json['year_established'];
    url = json['url'];
    imageURL = json['image'];
  }
}

List<Exchanges> exchangesList = [];