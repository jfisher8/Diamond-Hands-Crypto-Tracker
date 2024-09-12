class Exchanges {
  late String name;
  late int? yearEstablished;
  late String url;
  late String imageURL;
  late String? description;
  late int? trustScore;

  Exchanges(
      {required this.name,
      required this.yearEstablished,
      required this.url,
      required this.imageURL,
      required this.description,
      required this.trustScore});

  Exchanges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    yearEstablished = json['year_established'];
    url = json['url'];
    imageURL = json['image'];
    description = json['description'];
    trustScore = json['trust_score'];
  }
}

List<Exchanges> exchangesList = [];
