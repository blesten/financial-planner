import 'package:financial_planner/controllers/user_controller.dart';
import 'package:financial_planner/models/card_model.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CardController extends GetxController {
  final UserController _userController = Get.find<UserController>();

  final RxList<CardModel> _cards = <CardModel>[].obs;
  final RxString _error = "".obs;
  final RxBool _loading = false.obs;

  Future<void> fetchCards() async {
    try {
      _loading.value = true;

      final response = await http.get(
        Uri.parse("$serverURL/api/v1/cards"),
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['cards'];
        _cards.value = data.map((json) => CardModel.fromJson(json)).toList();
      } else {
        _error.value = json.decode(response.body)['msg'];
        throw Exception("Failed to fetch cards");
      }
    } catch (err) {
      _error.value = err.toString();
      throw Exception("Failed to fetch cards");
    } finally {
      _loading.value = false;
    }
  }

  Future<void> addCard({
    required String title,
    required String name,
    required String no,
    required String type,
    required bool contactless,
    required String expDate,
    required String color,
  }) async {
    _error.value = "";

    try {
      final response = await http.post(
        Uri.parse("$serverURL/api/v1/cards"),
        body: {
          "title": title,
          "name": name,
          "no": no,
          "type": type,
          "contactless": contactless ? "true" : "false",
          "expDate": expDate,
          "color": color,
        },
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 201) {
        final card = json.decode(response.body)['card'];

        _cards.insert(
          0,
          CardModel(
            id: card['_id'],
            title: card['title'],
            name: card['name'],
            no: card['no'],
            type: card['type'],
            contactless: card['contactless'],
            expDate: card['expDate'],
            color: card['color'],
          ),
        );
      } else {
        _error.value = json.decode(response.body)['msg'];
      }
    } catch (err) {
      _error.value = err.toString();
    }
  }

  Future<void> updateCard({
    required String id,
    required String title,
    required String name,
    required String no,
    required String type,
    required bool contactless,
    required String expDate,
    required String color,
  }) async {
    _error.value = "";

    try {
      final response = await http.patch(
        Uri.parse("$serverURL/api/v1/cards/$id"),
        body: {
          "title": title,
          "name": name,
          "no": no,
          "type": type,
          "contactless": contactless ? "true" : "false",
          "expDate": expDate,
          "color": color,
        },
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 200) {
        CardModel corrCard = _cards.firstWhere((element) => element.id == id);
        corrCard.title = title;
        corrCard.name = name;
        corrCard.no = no;
        corrCard.type = type;
        corrCard.contactless = contactless;
        corrCard.expDate = expDate;
        corrCard.color = color;
      } else {
        _error.value = json.decode(response.body)['msg'];
      }
    } catch (err) {
      _error.value = err.toString();
    }
  }

  Future<void> deleteCard({required String id}) async {
    _error.value = "";

    try {
      final response = await http.delete(
        Uri.parse("$serverURL/api/v1/cards/$id"),
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 200) {
        _cards.removeWhere((element) => element.id == id);
      } else {
        _error.value = json.decode(response.body)['msg'];
      }
    } catch (err) {
      _error.value = err.toString();
    }
  }

  String get error => _error.value;

  bool get loading => _loading.value;

  List<CardModel> get cards => _cards;
}
