class Exchanges {
  late String name;
  late int? yearEstablished;
  late String url;
  late String imageURL;
  late String? description;
  late int? trustScore;
  late String? country;
  late int? trustScoreRank;
  late bool? hasTradingIncentive;
  late String id;
  late int btc24HRtradeVolume;

  Exchanges(
      {required this.name,
      required this.yearEstablished,
      required this.url,
      required this.imageURL,
      required this.description,
      required this.trustScore,
      required this.country,
      required this.trustScoreRank});

  Exchanges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    yearEstablished = json['year_established'];
    url = json['url'];
    imageURL = json['image'];
    description = json['description'];
    trustScore = json['trust_score'];
    country = json['country'];
    trustScoreRank = json['trust_score_rank'];
  }

  factory Exchanges.fromFirestore(Map<String, dynamic> json) {
    return Exchanges(
    name: json['name'],
    yearEstablished: json['year_established'],
    url: json['url'],
    imageURL: json['image'],
    description: json['description'],
    trustScore: json['trust_score'],
    country: json['country'],
    trustScoreRank: json['trust_score_rank']);
  }
}

List<Exchanges> exchangesList = [];
