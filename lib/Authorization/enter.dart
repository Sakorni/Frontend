import 'dart:convert';
import 'package:http/http.dart' as http;
import './login_screen.dart';

//url хостинга бэкэнда.
const url = "http://www.vvd-rks.ru/proj/";

//Специальная ошибка на случай, если что-то пошло не так при получении карты.
//Например - сканировали не валидный QR
class CardException implements Exception {
  String message;
  CardException(this.message) {
    print("Raised exception with body $message");
  }
}

class User {
  String id;
  String name;
  String phone;
  String surname;
  String patronymic;
  String company;
  String position;
  String mail;
  String login;
  String card_id;
  List<String> own_cards;

  //Конструктор класса. Все поля пусты изначально.
  User({
    this.id = "",
    this.name = "",
    this.phone = "",
    this.surname = "",
    this.patronymic = "",
    this.company = "",
    this.position = "",
    this.mail = "",
    this.login = "",
    this.card_id = "",
    this.own_cards = const [""],
  });

  //Вывод всех полей пользователя. Нужен для дебага, вывод идёт в консоль.
  void PrintUser() {
    print("$login id is $id");
    print("$login name is $name");
    print("$login phone is $phone");
    print("$login surname is $surname");
    print("$login patronymic is $patronymic");
    print("$login company is $company");
    print("$login position is $position");
    print("$login mail is $mail");
    print("$login login is $login");
    print("$login card_id is $card_id");
    print("$login own cards are " + own_cards.toString());
  }
}

//Получение профиля из БД по его id и заполнение экземпляра класса User.
Future<void> getProfile(String id_user, User user_profile) async {
  String request = "$url?action=get-profile&id_user=$id_user";
  await http.get(request).then((response) async {
    var answer = json.decode(response.body)['response'];
    user_profile.id = answer['id'];
    user_profile.name = answer['name'];
    user_profile.phone = answer['phone'];
    user_profile.surname = answer['surname'];
    user_profile.patronymic = answer['patronymic'];
    user_profile.company = answer['company'];
    user_profile.position = answer['position'];
    user_profile.mail = answer['mail'];
    user_profile.login = answer['login'];
    user_profile.card_id = answer['own_card'];
    request = "$url?action=get-list-card&id_user=" + user_profile.id;
    print(request);
  }).then((_) async {
    await http.get(request).then((response) {
      // Ниже идёт запрос на получение списка визиток, доступных пользователю
      var answer = json.decode(response.body)['response'];
      print("Answer for cards is $answer");
      if (answer['status'] == 1) {
        //Если у пользователя есть карточки
        user_profile.own_cards = answer['cards'].cast<String>();
      }
      user_profile.PrintUser();
    });
  });
}

//Создание карточки. Прикрутить к регистрации.
Future<void> createCard(User user) async {
  String user_id = user.id;
  String card_name = "Визитка " + user.name;
  String card_caption =
      "Компания - " + user.company + ".\nДолжность - " + user.position;
  String _request =
      "$url?action=card-create&id_user=$user_id&card_name=$card_name&card_caption=$card_caption";
  await http.get(_request);
}

// Получение карточки от пользователя. Используется для qr-scan.
Future<void> getCard(String owner_id, String card_id, User user) async {
  String _request = "$url?action=give-card&id_owner=$owner_id&id_recipient=" +
      user.id +
      "&id_card=$card_id";
  await http.get(_request).then((response) {
    var answer = json.decode(response.body);
    if (answer['response']['status'] == 0) {
      //  Если не получилось - вызывается исколючение
      throw CardException(answer['response']['id']);
    }
  });
}

// Получение профиля по id его карточки
Future<void> getProfileFromCard(String card_id, User user) async {
  String _owner_id = "";
  String _request = "$url?action=get-card&id_card=$card_id";
  await http.get(_request).then(
    (response) {
      // Получение айди владельца карточки
      _owner_id = json.decode(response.body)["response"]["owner_id"];
    },
  ).then(
    (_) {
      print("New user!");
      getProfile(_owner_id, user); //Выгрузка его профиля из БД
      print("___" * 10);
    },
  );
}

//Функция входа в систему.
Future<void> logIn(
  String _login,
  String _password,
) async {
  String request =
      "$url?action=login&login=" + _login + "&password=" + _password;
  print(request);
  await http.get(request).then((response) {
    //Если пользователь с таким логином и паролем есть в БД, то всё хорошо.
    if (json.decode(response.body)['response']['status'] == 1) {
      print("Passed");
      passController = true;
      //Передача id юзера, сделавшего вход для дальнейшей выгрузки его профиля.
      user_id = json.decode(response.body)['response']['id_user'];
    } else {
      print("Not passed");
      passController = false;
    }
  });
}