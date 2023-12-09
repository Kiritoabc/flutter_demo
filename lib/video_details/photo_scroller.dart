import 'package:flutter/material.dart';

class PhotoScroller extends StatelessWidget {
  PhotoScroller(this.photoUrls, this.movieUrls);
  final List<String> photoUrls;
  final List<String> movieUrls;

  Widget _buildPhoto(BuildContext context, int index) {
    var photo = photoUrls[index];

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          child: Stack(
            children: [
              Image.network(
                photo,
                width: 160.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.play_circle),
                  onPressed: () {
                    print("更换视频");
                    // _updateCurrPlayIndex(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Photos',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(100.0),
          child: ListView.builder(
            itemCount: photoUrls.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
            itemBuilder: _buildPhoto,
          ),
        ),
      ],
    );
  }
}
