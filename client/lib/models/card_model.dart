class CardModel {
  String id;
  String title;
  String name;
  String no;
  String type;
  bool contactless;
  String expDate;
  String color;

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
