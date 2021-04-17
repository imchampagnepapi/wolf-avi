//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wolf_avatar/screens/avatar_screen.dart';
import 'package:wolf_avatar/utils/constants.dart';

class Utils{

  static final Utils _singletonUtils = Utils._internal();
  Utils._internal();

  factory Utils(){
    return _singletonUtils;
  }

  String constructAvatarUrl(String userId){
    return AVATAR_BASE_URL + userId + "&size=" + "1024";
  }

  Future<void> downloadImage(BuildContext context, String url, {AndroidDestinationType? destination, bool whenError = false, String? outputMimeType}) async {
    String fileName;
    String path;
    int size;
    String mimeType;
    try {
      String imageId;

      if (whenError) {
        imageId = (await ImageDownloader.downloadImage(url, outputMimeType: outputMimeType).catchError((error) {
          if (error is PlatformException) {
            var path = "";
            if (error.code == "404") {
              print("Not Found Error.");
            } else if (error.code == "unsupported_file") {
              print("UnSupported FIle Error.");
              path = error.details["unsupported_file_path"];
            }
          }
          print(error);
        }).timeout(Duration(seconds: 10), onTimeout: () {
          print("timeout");
          Fluttertoast.showToast(msg: "timeout");
          return;
        }))!;
      } else {
        if (destination == null) {
          imageId = (await ImageDownloader.downloadImage(
            url,
            outputMimeType: outputMimeType,
          ))!;
        } else {
          imageId = (await ImageDownloader.downloadImage(
            url,
            destination: destination,
            outputMimeType: outputMimeType,
          ))!;
        }
      }

      if (imageId == null) {
        return;
      }
      fileName = (await ImageDownloader.findName(imageId))!;
      path = (await ImageDownloader.findPath(imageId))!;
      size = (await ImageDownloader.findByteSize(imageId))!;
      mimeType = (await ImageDownloader.findMimeType(imageId))!;

      if(path != null){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => AvatarPreviewScreen(filePath: path,))).then((value) => Navigator.pop(context));
      }
    } on PlatformException catch (error) {
      Fluttertoast.showToast(msg: error.message!);
      print(error.message);
      return;
    }
  }

}