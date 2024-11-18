import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:trattoriasofia/helpers/helper.dart';
//import 'package:trattoriasofia/repositories/user_repository.dart';
//import 'package:gradient_widgets/gradient_widgets.dart';
//import 'package:merlfans/BottomNavigation/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';
//import 'package:merlfans/BottomNavigation/Home/home_page.dart';

class Functions {
  static Future<Map<String, dynamic>?> netCall(String url,
      {bool post = false, bool auth = true, Map<String, dynamic>? body}) async {
    Uri uri = Helper.getUri(url);
    Map<String, String> header = {};
    if (auth == true) {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString("current_user") != null) {
        header = {
          'Content-Type': 'application/json; charset=UTF-8',
          //'Authorization': //'Bearer ${currentUser.value.token}'
        };
      } else {
        header = {
          'Content-Type': 'application/json; charset=UTF-8',
        };
      }
    } else {
      header = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    }

    //if we use http we have to decode  response.body but we don't need to decode dio response.data
    try {
      Response response;
      final dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 5);
      print(uri.toString());
      if (post == false) {
        if (body != null) {
          response = await dio.get(uri.toString(),
              options: Options(headers: header), queryParameters: body);
        } else {
          response =
              await dio.get(uri.toString(), options: Options(headers: header));
        }
        //if (response.data  > 0) {
      } else {
        if (body != null) {
          response = await dio.post(uri.toString(),
              options: Options(headers: header), queryParameters: body);
        } else {
          response =
              await dio.post(uri.toString(), options: Options(headers: header));
        }
      }
      //if (response.persistentConnection == true) {
      if (response.statusCode == 200) {
        if (response.data["status"] == "success") {
          return {"status": "Ok", "data": response.data};
        } else {
          return {"status": "Error", "data": response.data['msg']};
        }
      } else {
        return {
          "status": "Error",
          "data": "some probelm with api"
        }; //await CheckUserConnection()};
      }
    } catch (e) {
      print(e);
      return {"status": "Error", "data": await CheckUserConnection()};
    }
  }

  static Future<String> CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return "issue with backend service";
      } else {
        return "No Internet Connection";
      }
    } on SocketException catch (_) {
      return "No Internet Connection";
    }
  }

  static Future<String> checkInternet() async {
    try {
      var checkinternet = await http.get(Uri.parse("https://google.com"));
      if (checkinternet == true) {
        return "issue with backend service";
      } else {
        return "No Internet Connection";
      }
    } catch (e) {
      return "No Internet Connection";
    }
  }

  static toast(String msg, Color color) {
    msg = removeTrailing("\n", msg);
    return SnackBar(
      duration: const Duration(seconds: 4),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  static String removeTrailing(String pattern, String from) {
    int i = from.length;
    while (from.startsWith(pattern, i - pattern.length)) i -= pattern.length;
    return from.substring(0, i);
  }

  static fSafeChar(var data) {
    if (data == null) {
      return "";
    } else {
      return data;
    }
  }

  static fSafeNum(var data) {
    if (data == null) {
      return 0;
    } else {
      return data;
    }
  }
}

void logout(BuildContext context) async {
  SharedPreferences? prefs = await SharedPreferences.getInstance();
  Dialog fancyDialog = Dialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    child: Container(
      height: 210.0,
      width: 300.0,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        //color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        children: <Widget>[
          Container(
              height: 150,
              decoration: const BoxDecoration(
                //color: Color(0xff2e2f34),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/gif-logo.gif',
                        width: 80, fit: BoxFit.fill),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Text(
                          "Do you really want to logout?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
            child: Container(
                decoration: const BoxDecoration(
                  //color: Color(0xff2e2f34),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop("Discard");
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: const BoxDecoration(
                            //gradient: Gradients.blush,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: const Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'RockWellStd'),
                            ),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          String? uniqueId =
                              (prefs.getString('unique_id') == null)
                                  ? ""
                                  : prefs.getString('unique_id');
                          Navigator.of(context, rootNavigator: true)
                              .pop("Discard");
                          //_logOutFromSocial(prefs);
                          prefs.clear();
                          prefs.setString("unique_id", uniqueId.toString());
                          /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigation() //HomePage(video),
                                ),
                          );
                          */
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: const BoxDecoration(
                            // gradient: Gradients.blush,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: const Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'RockWellStd'),
                            ),
                          ),
                        )),
                  ],
                )),
          ),
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => fancyDialog);
}
/*

Future<Null> _logOutFromSocial(prefs) async {
  if (prefs.getString("login_type") != null) {
    if (prefs.getString("login_type") == 'FB') {
      prefs.clear();
      FacebookLogin facebookSignIn = new FacebookLogin();
      await facebookSignIn.logOut();
    } else {
      prefs.clear();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    }
  } else {
    prefs.clear();
  }
}

*/
