import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class FullScreenUI extends StatefulWidget {
  static var routeName = '/fullScreen';
  final url;

  const FullScreenUI({Key? key, this.url}) : super(key: key);

  @override
  _FullScreenUIState createState() => _FullScreenUIState();
}

class _FullScreenUIState extends State<FullScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Wallpaper App'),
        ),
      ),
      body: Column(children: [
        Expanded(flex: 3, child: Image.network(widget.url)),
        Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {},
              child: Text('Set a WallPaper'),
            )),
      ]),
    );
  }

  Future<void> setWallpaperFromFile() async {
    String result;
    var file = await DefaultCacheManager().getSingleFile('url');
// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
// If the widget was removed from the tree while the asynchronous platform
// message was in flight, we want to discard the reply rather than calling
// setState to update our non-existent appearance.
    if (!mounted) return;
  }
}
