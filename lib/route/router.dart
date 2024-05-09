import 'package:go_router/go_router.dart';
import 'package:online_photo_gallery/components/image_fullscreen_view.dart';
import 'package:online_photo_gallery/models/image_model.dart';
import '../screens/home_page.dart';
import '../screens/splash.dart';


final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Splash(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/image/:imageId',
      builder: (context, state) => FullScreenImageView(image: state.extra as ImageModel),
    ),
  ]
);