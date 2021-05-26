import 'package:flutter/material.dart';
import 'package:flutter_app/models/gallery.dart';
import 'package:photo_view/photo_view.dart';

class _GalleryItem extends StatelessWidget {
  final String imagePath;
  _GalleryItem({
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: AssetImage(imagePath),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.6,
      )
    );
  }
}

class GalleryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Text(
                'Last photos',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
              margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
            ),
            Expanded(
              child: Container(
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
                            builder: (context) => _GalleryItem(
                              imagePath: GalleryModel.getByIndex(index),
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
                              image: AssetImage(GalleryModel.getByIndex(index)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: GalleryModel.getCount(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
