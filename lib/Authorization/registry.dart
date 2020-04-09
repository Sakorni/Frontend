import 'package:flutter/material.dart';
import 'package:shared/Authorization/login_screen.dart';
import '../Helpers/enter.dart';
import '../mainpage.dart';

String _name = "";
String _surname = "";
String _patronymic = "";
String _company = "";
String _position = "";
String _mail = "";
String _phone = "";
String _login = "";
String _password = "";
bool loginExist = false;
bool _passwordCheck = true;

//bool _buttonEnabled = !loginExist && _passwordCheck && allFieldsNotNull;

class Registry extends StatefulWidget {
  @override
  _RegistryState createState() => _RegistryState();
}

class _RegistryState extends State<Registry> {
  final TextStyle style = TextStyle(
      color: Colors.black,
      fontFamily: 'Montserrat',
      fontSize: 25,
      fontWeight: FontWeight.bold);

  @override
  void initState() => super.initState();
  Widget build(BuildContext context) {
    final _loginField = Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Логин пользователя:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),),
            TextFormField(
              style: style,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _login = value;
              },
              onSaved: (value) {
                if (value != "")
                  checkLogin(value.toLowerCase()).then((_) => setState(() {}));
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,             
                  hintText: 'Login',
                  border: OutlineInputBorder(gapPadding: 10)),
            ),
            loginExist
                ? Text("Такой логин уже существует!",
                    style:
                        TextStyle(color: Colors.redAccent[700], fontSize: 22))
                : _login != ""
                    ? Text("Логин не занят",
                        style:
                            TextStyle(color: Colors.greenAccent, fontSize: 15))
                    : Padding(padding: EdgeInsets.all(0)),
          ],
        ));

    final _passwordField = Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            _passwordCheck
                ? Text("Пароль:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),)
                : Text("Пароль должен содержать больше 4 символов!",
                    style:
                        TextStyle(color: Colors.redAccent[700], fontSize: 22)),
            TextFormField(
              style: style,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _password = value;
              },
              onSaved: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,  
                  hintText: 'Password',
                  border: OutlineInputBorder(gapPadding: 10)),
            ),
          ],
        ));

    final _nSPField = Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Фамилия:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),),
          TextFormField(
            style: style,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              _surname = value;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,  
                hintText: 'Фамилия',
                border: OutlineInputBorder(gapPadding: 10)),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Text("Имя:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),),
          TextFormField(
            style: style,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              _name = value;
            },
            decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,                  
                hintText: 'Имя', border: OutlineInputBorder(gapPadding: 10)),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Text("Отчество:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),),
          TextFormField(
            style: style,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              _patronymic = value;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,  
                hintText: 'Отчество',
                border: OutlineInputBorder(gapPadding: 10)),
          ),
        ],
      ),
    );

    final _loginAndPasswordField = Column(
      children: [
        _loginField,
        Padding(padding: EdgeInsets.all(10)),
        _passwordField,
      ],
    );

    final _phoneAndEmail = Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Номер телефона:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),),
          TextFormField(
            style: style,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              _phone = value;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, 
              hintText: '+7-000-000-00-00',
              border: OutlineInputBorder(gapPadding: 10),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Text("E-mail:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),),
          TextFormField(
            style: style,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              _mail = value;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white, 
                hintText: 'example@exmaple.com',
                border: OutlineInputBorder(gapPadding: 10)),
          ),
        ],
      ),
    );

    final _companyAndPosition = Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Место работы:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),),
          TextFormField(
            style: style,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              _company = value;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white, 
                hintText: 'Место работы',
                border: OutlineInputBorder(gapPadding: 10)),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Text("Должность:", style: TextStyle( fontFamily:'Comic', color: Colors.white ),),
          TextFormField(
            style: style,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              _position = value;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white, 
                hintText: 'Должность',
                border: OutlineInputBorder(gapPadding: 10)),
          ),
        ],
      ),
    );

    final _register = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Color(0xff3498DB),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          print("Trying to register...");
          bool allFieldsNotNull = _name != "" &&
              _surname != "" &&
              _patronymic != "" &&
              _company != "" &&
              _position != "" &&
              _mail != "" &&
              _mail.contains('@') &&
              _phone != "" &&
              _login != "";
          if (allFieldsNotNull) {
            checkLogin(_login).then(
              (_) {
                print("Login checked! Login exist is $loginExist");
                _passwordCheck = _password.length > 4;
                if (_passwordCheck && !loginExist) {
                  registry(_name, _surname, _patronymic, _company, _position,
                      _mail, _phone, _login, _password);
                } else
                  setState(() {});
              },
            ).then((_) {
              if (passController)
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => App()));
            });
          } else {
            print("Не вышло, поля не заполнены");
          }
        },
        child: Text("Зарегестрироваться",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final _cancel = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Color(0xff3498DB),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          print("Fuck, go back!");
          Navigator.pop(context);
          /* Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));*/
        },
        child: Text("Отмена",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final _buttons = Column(
      children: [_register, Padding(padding: EdgeInsets.all(10)), _cancel],
    );

    return Scaffold(
        backgroundColor: Color(0xff22313F),
        body: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(children: [
          _loginAndPasswordField,
          _nSPField,
          _phoneAndEmail,
          _companyAndPosition,
          _buttons,
        ]),
      ),
    ));
  }
}
