import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final int likes, views;

  const ImageCard({required this.imageUrl, this.likes = 0, this.views = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade200,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(imageUrl))),
                  ),
                  // Mask
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                  // Likes & Views Count
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        // Likes
                        const Icon(
                          Icons.favorite_rounded,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          likes.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Views
                        const Icon(
                          Icons.visibility_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          views.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }
}