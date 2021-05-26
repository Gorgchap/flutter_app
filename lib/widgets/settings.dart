import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/popup.dart';
import 'package:flutter_app/models/settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  File? _avatar;
  final picker = ImagePicker();

  onLoginChanged(BuildContext context, String login) {
    setState(() {
      context.read<SettingsModel>().setLogin(login);
    });
  }

  Future getImage(ImageSource imgSource) async {
    final pickedFile = await picker.getImage(source: imgSource);

    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
        context.read<SettingsModel>().setAvatar(_avatar as File);
      } else {
        print('No image selected.');
      }
    });
  }

  void openPopup(String title, String content) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => Popup(title: title, content: content),
        transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      )
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Gallery'),
                  onTap: () {
                    getImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  }
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    File? avatar = _avatar ?? context.read<SettingsModel>().avatar;
    String login = context.read<SettingsModel>().login;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
              margin: EdgeInsets.all(15),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  child: avatar == null
                    ? Container(
                        width: 150,
                        height: 150,
                        decoration: new BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                      child: Icon(Icons.camera_alt, color: Colors.grey[800]),
                    )
                    : CircleAvatar(
                        backgroundImage: FileImage(avatar),
                        radius: 75,
                      )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                initialValue: login,
                decoration: InputDecoration(hintText: 'Login'),
                style: TextStyle(fontSize: 22, color: Colors.black),
                minLines: 1,
                maxLines: 1,
                onChanged: (login) => onLoginChanged(context, login),
              )
            ),
          ],
        )
      )
    );
  }
}