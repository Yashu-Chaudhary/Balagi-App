import 'package:balagi_bhjans/provider/audio_provider.dart';
import 'package:balagi_bhjans/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AudioProvider())],
      child: ScreenUtilInit(
          designSize: Size(430, 932),
          minTextAdapt: true,
          builder: (context, _) {
            return MaterialApp.router(
              title: 'Balagi Bhajans',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              routerConfig: router,
            );
          }),
    );
  }
}
