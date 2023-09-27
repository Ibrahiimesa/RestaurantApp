import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/response/restaurant_response.dart';

void main() {
  var dummyList = {
    "error": false,
    "message": "success",
    "count": 3,
    "restaurants": [
      {
        "id": "uewq1zg2zlskfw1e867",
        "name": "Kafein",
        "description":
            "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.",
        "pictureId": "15",
        "city": "Aceh",
        "rating": 4.6
      },
      {
        "id": "ygewwl55ktckfw1e867",
        "name": "Istana Emas",
        "description":
            "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.",
        "pictureId": "05",
        "city": "Balikpapan",
        "rating": 4.5
      },
      {
        "id": "dwg2wt3is19kfw1e867",
        "name": "Drinky Squash",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.",
        "pictureId": "18",
        "city": "Surabaya",
        "rating": 3.9
      },
    ]
  };

  var dummyDetail = {
    "error": false,
    "message": "success",
    "restaurant": {
      "id": "uewq1zg2zlskfw1e867",
      "name": "Kafein",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.",
      "city": "Aceh",
      "address": "Jln. Belimbing Timur no 27",
      "pictureId": "15",
      "categories": [
        {"name": "Italia"},
        {"name": "Jawa"}
      ],
      "menus": {
        "foods": [
          {"name": "Salad lengkeng"},
          {"name": "Kari terong"},
          {"name": "Sosis squash dan mint"},
        ],
        "drinks": [
          {"name": "Minuman soda"},
          {"name": "Es teh"},
          {"name": "Jus tomat"},
        ]
      },
      "rating": 4.6,
    }
  };

  group('Restaurant Test', () {
    test('Parsing List Result JSON', () async {
      var result = RestaurantResponse.fromJson(dummyList);

      expect(result.error, dummyList["error"]);
      expect(result.message, dummyList["message"]);
      expect(result.count, dummyList["count"]);
      expect(result.restaurants[0].id, "uewq1zg2zlskfw1e867");
      expect(result.restaurants[1].id, "ygewwl55ktckfw1e867");
      expect(result.restaurants[2].id, "dwg2wt3is19kfw1e867");
      expect(result.restaurants.length, 3);
    });

    test('Parsing Detail Result JSON', () async {
      var result = RestaurantDetailResponse.fromJson(dummyDetail);

      expect(result.error, dummyList["error"]);
      expect(result.message, dummyList["message"]);
      expect(result.restaurant.id, "uewq1zg2zlskfw1e867");
      expect(result.restaurant.name, 'Kafein');
    });
  });
}
