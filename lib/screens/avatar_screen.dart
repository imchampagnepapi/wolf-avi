// Created by DB on 18-11-2020.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolf_avatar/widgets/reusable_widgets.dart';

class AvatarPreviewScreen extends StatefulWidget{

  final String? filePath;

  const AvatarPreviewScreen({Key? key, this.filePath}) : super(key: key);
  @override
  _AvatarPreviewScreenState createState() => _AvatarPreviewScreenState();
}

class _AvatarPreviewScreenState extends State<AvatarPreviewScreen> {

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: ReusableWidgets.getAppBar("Preview Screen"),
      ),
      body: SizedBox.expand(
        child: InteractiveViewer(
          maxScale: 5.0,
          minScale: 1.0,
          child: Image.file(File(widget.filePath!)),
        )
      ),
    );
  }
}