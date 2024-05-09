import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_photo_gallery/models/image_model.dart';
import 'package:photo_view_x/photo_view_x.dart';

class FullScreenImageView extends StatefulWidget {
  final ImageModel image;
  const FullScreenImageView({required this.image, super.key});

  @override
  State<FullScreenImageView> createState() => _FullScreenImageViewState();
}

class _FullScreenImageViewState extends State<FullScreenImageView>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    var sys = MediaQuery.of(context);
    var thumbnailView = sys.size.width * sys.devicePixelRatio;

    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _animation as Animation<double>,
        child: ScaleTransition(
          scale: _animation as Animation<double>,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                
                PhotoView(          // fulscreen view
                  tapEnabled: true,
                  child: Hero(
                    tag: widget.image.tags,
                    transitionOnUserGestures: true,
                    child: Center(
                      child: CachedNetworkImage(
                          imageUrl: widget.image.largeImageUrl,
                          fit: BoxFit.fitHeight,
                          width: thumbnailView),
                    ),
                  ),
                ),
                
                Align(          // Meta data
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: thumbnailView,
                    height: 60,
                    color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.4),
                    child: Row(
                      children: [
                        const SizedBox(width: 20,),
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              widget.image.userImageUrl),
                          radius: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.image.user,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),

                        const Spacer(),


                        const Icon(         // Likes
                          Icons.favorite_rounded,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.image.likes.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        
                        const Icon(       // Views
                          Icons.visibility_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.image.views.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                        const Icon(     // Downloads
                          Icons.download_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.image.downloads.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(width: 20,),
                      ],
                    ),
                  ),
                ),
                // Back Button
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () => context.pop(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
