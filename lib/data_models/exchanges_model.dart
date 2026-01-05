class Exchanges {
  late String? name;
  late int? yearEstablished;
  late String? url;
  late String? imageURL;
  late String? description;
  late int? trustScore;
  late String? country;
  late int? trustScoreRank;
  late bool? hasTradingIncentive;
  late String? id;
  late num? btc24HRtradeVolume;

  Exchanges({
    this.name,
    this.yearEstablished,
    this.url,
    this.imageURL,
    this.description,
    this.trustScore,
    this.country,
    this.trustScoreRank,
    this.hasTradingIncentive,
    this.id,
    this.btc24HRtradeVolume,
  });

  Exchanges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    yearEstablished = json['year_established'];
    url = json['url'];
    imageURL = json['image'];
    description = json['description'];
    trustScore = json['trust_score'];
    country = json['country'];
    trustScoreRank = json['trust_score_rank'];
    hasTradingIncentive = json['has_trading_incentive'];
    id = json['id'];
    btc24HRtradeVolume = json['trade_volume_24h_btc'];
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
      trustScoreRank: json['trust_score_rank'],
      hasTradingIncentive: json['has_trading_incentive'],
      id: json['id'],
      btc24HRtradeVolume: json['trade_volume_24h_btc'],
    );
  }

  @override
  String toString() {
    return 'Exchanges{'
        'name: $name, '
        'yearEstablished: $yearEstablished, '
        'url: $url, '
        'imageURL: $imageURL, '
        'description: $description, '
        'trustScore: $trustScore, '
        'country: $country, '
        'trustScoreRank: $trustScoreRank, '
        'hasTradingIncentive: $hasTradingIncentive, '
        'id: $id, '
        'btc24HRtradeVolume: $btc24HRtradeVolume'
        '}';
  }
}

List<Exchanges> exchangesList = [];
