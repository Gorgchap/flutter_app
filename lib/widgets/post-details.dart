import 'package:flutter/material.dart';
import 'package:flutter_app/models/posts.dart';
import 'package:intl/intl.dart';

class PostDetails extends StatelessWidget {
  final Post post;
  PostDetails({
    required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: 'logo',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                    ),
                    image: DecorationImage(
                      image: FileImage(post.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 260,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateFormat.MMMMd().add_Hm().format(post.dateTime),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: Text(
                        post.description,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Go back'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
