import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wallpaper_app/api/get_pics_api.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaper_app/model/pic_model.dart';

class HomeUI extends StatefulWidget {
  static var routeName = '/home';

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  List<PicModel> pics = [];
  int count = 1;
  bool loading = true;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      scrollController.addListener(scrollListener());
    });
    getListOfPics(count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Wallpaper App'),
        ),
      ),
      body: Column(
        children: [
          //result List
          resultList(),
        ],
      ),
      floatingActionButton: loading == true
          ? Align(
              alignment:
                  pics.isEmpty ? Alignment.center : Alignment.bottomCenter,
              child: const CircularProgressIndicator())
          : Container(),
    );
  }

  resultList() {
    return Expanded(
      child: ListView.builder(
          controller: scrollController,
          cacheExtent: 3000,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: pics.length,
          itemBuilder: (context, index) {
            if (pics.isNotEmpty) {
              return InkWell(
                onTap: () {},
                child: CachedNetworkImage(
                  imageUrl: pics[index].downloadUrl!,
                  placeholder: (context, url) => Text('Loading...'),
                  fit: BoxFit.fill,
                  // loadingBuilder: (BuildContext context, Widget child,
                  //     ImageChunkEvent? loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       value: loadingProgress.expectedTotalBytes != null
                  //           ? loadingProgress.cumulativeBytesLoaded /
                  //               loadingProgress.expectedTotalBytes!
                  //           : null,
                  //       color: Colors.yellow,
                  //     ),
                  //   );
                  // },
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print('hello');
      getListOfPics(count + 1);
    }
  }

  getListOfPics(int c) async {
    setState(() {
      loading = true;
    });

    await GetPicApi(pageCount: count).fetch().then((List<PicModel> value) {
      if (value.isNotEmpty) {
        pics.addAll(value);
        setState(() {
          loading = false;
        });
      }
    });
  }
}
