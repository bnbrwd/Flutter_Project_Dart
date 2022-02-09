import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//clear image that cache are using.

class CachedImageScreen extends StatefulWidget {
  @override
  _CachedImageScreenState createState() => _CachedImageScreenState();
}

class _CachedImageScreenState extends State<CachedImageScreen> {
  // Widget buildImage(int index) => CircleAvatar(
  //       // var url = 'https://images.unsplash.com/random?sig=$index';
  //       backgroundImage: CachedNetworkImageProvider(
  //           'https://source.unsplash.com/random?sig=$index'),
  //     );

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: Duration(days: 15),
      //cache will removed if it is not used for 15 days.
      maxNrOfCacheObjects: 100,
      //here maximaum 100 image will store if we add another then oldest will remove and new one will store
    ),
  );

  Widget buildImage(int index) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          // cacheManager: customCacheManager,
          key: UniqueKey(),
          imageUrl: 'https://source.unsplash.com/random?sig=$index',
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          maxHeightDiskCache:
              75, //this will resize the pic before cached width will be 75 pixel and height will be dynamic.
          placeholder: (context, url) => Container(color: Colors.grey),
          //it will show grey color inj image box if network not available.
          // errorWidget: (context, url, error) => Container(
          //   color: Colors.black12,
          //   child: Icon(
          //     Icons.error,
          //     color: Colors.red,
          //   ),
          // ),
        ),
      );

  void clearCache() {
    // DefaultCacheManager().emptyCache();
    //it will delete all image from cache

    // when we click on clear image it will not take again from internet it will take from cache.
    imageCache.clear();
    imageCache.clearLiveImages();
    setState(() {}); //update ui after clear image
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cache Network Images'),
        actions: [
          TextButton(
            child: Text('Clear Cache'),
            style: TextButton.styleFrom(primary: Colors.green),
            onPressed: clearCache,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 30,
        itemBuilder: (context, index) => Card(
          color: Colors.white,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            leading: buildImage(index),
            title: Text(
              'Image ${index + 1}',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
