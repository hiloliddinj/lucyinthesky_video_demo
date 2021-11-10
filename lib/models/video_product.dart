import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:lucyinthesky_video_demo/models/product.dart';
import 'package:lucyinthesky_video_demo/screens/detail_screen.dart';

class VideoProduct extends StatefulWidget {
  const VideoProduct({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _VideoProductState createState() => _VideoProductState();
}

class _VideoProductState extends State<VideoProduct> {
  late VideoPlayerController _controller;

  Color playIconColor = Colors.white.withOpacity(0);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.product.regularVideo)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.product.regularVideo == ''
                ? NetworkImage(widget.product.image)
                : NetworkImage(widget.product.regularVideoPoster),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: widget.product.regularVideo == ''
                      ? Container()
                      : VideoPlayer(_controller),
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.play_arrow,
                size: 70,
                color: playIconColor,
              ),
            ),
            Column(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(flex: 6, child: Container()),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.ios_share,
                                            size: 35, color: Colors.white),
                                        Icon(Icons.favorite,
                                            size: 35, color: Colors.white),
                                        Icon(Icons.shopping_bag_outlined,
                                            size: 35, color: Colors.white),
                                      ],
                                    )),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Container()),
                                Expanded(
                                  flex: 30,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.product.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              widget.product.price,
                                              style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(widget.product.special,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Expanded(flex: 1, child: Container()),
                      ],
                    )),
              ],
            ),
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                          playIconColor = Colors.white.withOpacity(0.6);
                        } else {
                          _controller.play();
                          playIconColor = Colors.white.withOpacity(0);
                        }
                      });
                    },
                    onPanUpdate: (detail) {
                      if (detail.delta.dx < 0) {
                        Navigator.pushNamed(context, DetailScreen.id);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
