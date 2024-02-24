class CardModel {
  final String id;
  final String title;
  final String name;
  final String no;
  final String type;
  final bool contactless;
  final String expDate;
  final String color;

  CardModel({
    required this.id,
    required this.title,
    required this.name,
    required this.no,
    required this.type,
    required this.contactless,
    required this.expDate,
    required this.color,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['_id'],
      title: json['title'],
      name: json['name'],
      no: json['no'],
      type: json['type'],
      contactless: json['contactless'],
      expDate: json['expDate'],
      color: json['color'],
    );
  }
}
