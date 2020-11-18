// Created by DB on 18-11-2020.

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolf_avatar/utils/click_debouncer.dart';
import 'package:wolf_avatar/utils/constants.dart';
import 'package:wolf_avatar/utils/hex_color.dart';

class ReusableWidgets{

  static TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  static Widget getTitleImage(){
    return Image.asset('assets/images/logo_wolf.png', fit: BoxFit.fitHeight, width: 180, height: 180.0,);
  }

  static Widget getAppBar(String title){
    return AppBar(
      title: Center(
        child: Text(title, style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Assemblage'),),
      ),
      flexibleSpace: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [HexColor("#ffca02"), HexColor("#fe0684"), HexColor("#c508e4"), HexColor("#3c50f4"),],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.clamp),
        ),
      ),
    );
  }

  static Widget buildBottomSheet(BuildContext context){
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            HexColor("#ffca02"),
            HexColor("#fe0684"),
            HexColor("#c508e4"),
            HexColor("#3c50f4"),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(FOOTER_TEXT,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Assemblage', fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildBtn(BuildContext context, Function clickFunc){
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(8.0),
      color: HexColor("#3c50f4"),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: clickFunc,
        child: Text("Fetch",
            textAlign: TextAlign.center,
            style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  static Widget getUserIdInputField(String hint, bool isPwd, String pathToImage, TextEditingController txtController){
    return TextField(
      style: TextStyle(fontSize: 20.0, color: Colors.blueGrey.shade600, fontWeight: FontWeight.bold, fontFamily: 'Open Sans Extrabold'),
      obscureText: isPwd,
      controller: txtController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: 'Open Sans Extrabold'),
          suffixIcon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(pathToImage, width: 2.0,height: 2.0,),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
    );
  }

  static Widget getNormalSmallCircularPB(){
    return CircularProgressIndicator();
  }

  static getSmallCircularProgressBar(BuildContext context, String dialogMsg){
    return
      showDialog(barrierDismissible: false,
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.all(2.0),
            content: new Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 60, maxWidth: 70, minWidth: 60, maxHeight: 70,
                  ),
                  child: FlareActor(
                    "assets/flare/pb-circular.flr",
                    animation: "Loading",
                    //color: Colors.red,
                  ),
                ),
                Container(margin: EdgeInsets.only(left: 8.0),
                    child: FittedBox(
                      child: Text('$dialogMsg',
                        style: TextStyle(color: HexColor("#164f6e"), fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontSize: 14.0),),
                      fit: BoxFit.fitWidth,)),
              ],),
          );
        },
      );
  }
}