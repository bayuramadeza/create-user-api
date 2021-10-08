import 'package:flutter/material.dart';
import 'package:social_media/utils/constanta.dart';
import 'package:social_media/utils/preferences_config.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;

  @override
  void initState() {
    getDataPreferences();
    super.initState();
  }

  getDataPreferences()async{
    setState(() {
      name = PreferencesConfig.getString(USER_FIRST_NAME_KEY)+ ' '+PreferencesConfig.getString(USER_LAST_NAME_KEY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: name==null?const CircularProgressIndicator() :  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("My name is $name"),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: (){
              PreferencesConfig.clearData();
              Navigator.pushReplacementNamed(context, '/createUser');
            }, child: const Text("Clear Data"))
          ],
        ),
      ),
    );
  }
}