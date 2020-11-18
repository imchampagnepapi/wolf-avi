// Created by DB on 18-11-2020.

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wolf_avatar/utils/click_debouncer.dart';
import 'package:wolf_avatar/utils/hex_color.dart';
import 'package:wolf_avatar/utils/utils.dart';
import 'package:wolf_avatar/widgets/reusable_widgets.dart';

class HomeScreen extends StatefulWidget{

  final String title;
  const HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _userIdTxtController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
  }

  Widget buildHomepageBody(){
    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [HexColor("#ffca02"), HexColor("#fe0684"), HexColor("#c508e4"), HexColor("#3c50f4"),],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(36.0, 0.0,36.0,0.0),
        child: ListView(
          children: <Widget>[
            ReusableWidgets.getTitleImage(),
            SizedBox(height: 10.0),
            ReusableWidgets.getUserIdInputField('User ID', false, 'assets/images/user.png', _userIdTxtController),
            SizedBox(height: 20.0),
            ReusableWidgets.buildBtn(context, onFetchBtnClicked),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(widget.title),
      resizeToAvoidBottomInset : false,
      bottomSheet: ReusableWidgets.buildBottomSheet(context),
      body: buildHomepageBody()
    );
  }

  void onFetchBtnClicked(){
    _debouncer.run(() {
      ReusableWidgets.getSmallCircularProgressBar(context, "Please Wait");
      print(_userIdTxtController.text);
      String _url = Utils().constructAvatarUrl(_userIdTxtController.text);
      print(_url);
      _startDownloadingAvatar(_url);
    });
  }

  void _startDownloadingAvatar(String url) {
    Utils().downloadImage(context, url).then((value) {
      Fluttertoast.showToast(msg: "Image Saved!", backgroundColor: Colors.black87, textColor: Colors.white,);
    });
  }

}