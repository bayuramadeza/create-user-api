import 'package:flutter/material.dart';
import 'package:social_media/pages/post/create_post.dart';
import 'package:social_media/pages/users/create_user.dart';
import 'package:social_media/utils/preferences_config.dart';

import 'pages/home/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateUser(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => const Home(),
        '/createUser': (BuildContext context) => const CreateUser(),
        '/createPost': (BuildContext context) => const CreatePost(),
      },
    );
  }
}
