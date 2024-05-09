import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_photo_gallery/config.dart';
import 'package:online_photo_gallery/utils.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.forward();
    // Initialize app & user data
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 3), () async {
        context.go('/home');
      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FadeTransition(
      opacity: _animation as Animation<double>,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [PRIMARY_COLOR.withOpacity(0.5), SECONDARY_COLOR],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                  image: const DecorationImage(
                      image: AssetImage(APP_ICON_IMG), fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              APP_NAME,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Text(
              ' - Developed with ❤️',
              style: TextStyle(color: Colors.grey.shade200, fontSize: 12),
            )
          ],
        ),
      ),
    ));
  }
}
