import 'package:balagi_bhjans/screens/home_scree.dart';
import 'package:balagi_bhjans/screens/playing_screen.dart';
import 'package:balagi_bhjans/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: '/splash-screen',
  routes: [
    GoRoute(
      path: '/splash-screen',
      name: 'SplashScreen',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'HomeScreen',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/playing-screen',
      name: 'Playing Screen',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return PlayingScreen(
          index: extra['index']!,
          title: extra['title']!,
          image: extra['image']!,
          audio: extra['audio']!,
        );
      },
    )
  ],
);
