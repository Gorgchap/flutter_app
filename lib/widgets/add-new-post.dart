import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/popup.dart';
import 'package:flutter_app/models/posts.dart';
import 'package:flutter_app/models/settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewPostWidget extends StatefulWidget {
  const AddNewPostWidget({Key? key}) : super(key: key);

  @override
  State<AddNewPostWidget> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPostWidget> {
  File? _image;
  String _description = '';
  bool _isSaveDisabled = true;
  final descriptionHolder = TextEditingController();
  final picker = ImagePicker();
  final uuid = Uuid();

  onDescriptionChanged(String description) {
    setState(() {
      _description = description;
      _isSaveDisabled = _image == null || _description == '';
    });
  }

  Future getImage(ImageSource imgSource) async {
    final pickedFile = await picker.getImage(source: imgSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      _isSaveDisabled = _image == null || _description == '';
    });
  }

  void resetImage() {
    setState(() {
      _image = null;
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                'New post',
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
                child: _image != null
                  ? ClipRRect(
                      child: Image.file(
                        _image as File,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      width: 200,
                      height: 200,
                      child: Icon(Icons.camera_alt, color: Colors.grey[800]),
                    )
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                controller: descriptionHolder,
                decoration: InputDecoration(hintText: 'Enter description of post'),
                style: TextStyle(fontSize: 22, color: Colors.black),
                minLines: 1,
                maxLines: 5,
                onChanged: onDescriptionChanged
              )
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                onPressed: _isSaveDisabled
                  ? () => openPopup('Error', 'Fill all fields correctly')
                  : () {
                      context.read<PostsModel>().addPost(
                        new Post(
                          id: uuid.v4(),
                          image: _image as File,
                          dateTime: DateTime.now(),
                          description: _description
                        )
                      );
                      openPopup('Saved', 'Created successfully');
                      resetImage();
                      descriptionHolder.clear();
                    },
                child: Text('Save'),
              )
            ),
          ],
        )
      )
    );
  }
}
