import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/posts.dart';
import 'package:flutter_app/models/settings.dart';
import 'package:flutter_app/widgets/post-details.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    File? avatar = context.read<SettingsModel>().avatar;
    String login = context.read<SettingsModel>().login;
    List<Post> posts = context.read<PostsModel>().reversedPosts;
    int postsCount = context.read<PostsModel>().getCount();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 10,
                    ),
                    child: avatar == null
                      ? CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 50,
                          child: login.isEmpty ? null : Text(login[0]),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(avatar),
                          radius: 50,
                        )
                  ),
                  Text(
                    login,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: postsCount > 0
                ? Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetails(
                                post: posts[index],
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'logo$index',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: FileImage(posts[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: postsCount,
                  ),
                )
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No posts added yet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      )
                    )
                  ),
            )
          ],
        ),
      ),
    );
  }
}
