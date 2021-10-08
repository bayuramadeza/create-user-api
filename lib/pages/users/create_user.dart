import 'package:flutter/material.dart';
import 'package:social_media/services/user_service.dart';
import 'package:social_media/utils/constanta.dart';
import 'package:social_media/utils/preferences_config.dart';
import 'package:social_media/utils/validation.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({ Key? key }) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  bool isEmailValid = true;
  bool isFetchingData = false;

  @override
  void initState() {
    getDataPreferences();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  getDataPreferences()async{
    await Future.delayed(const Duration(seconds: 2));
    String id = PreferencesConfig.getString(USER_ID_KEY);
    if(id.isNotEmpty){
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget textFieldCustom({@required TextEditingController? controller, @required String? hint, bool isDataValid = true}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          errorText: isDataValid? null : "Format tidak seusai",
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }

  createUser(String firstName, String lastName, String email)async{
    setState(() {
      isFetchingData = true;
    });
    final service = UserService();
    try{
      final user = await service.createUser(firstName, lastName, email);
      PreferencesConfig.setString(USER_ID_KEY, user.id);
      PreferencesConfig.setString(USER_EMAIL_KEY, user.email);
      PreferencesConfig.setString(USER_FIRST_NAME_KEY, user.firstName);
      PreferencesConfig.setString(USER_LAST_NAME_KEY, user.lastName);
      Navigator.pushNamed(context, '/home');
    } catch(e){
        showDialog(context: context, builder: (_){
          return AlertDialog(
            title: Text(e.toString(), maxLines: 8,),
            content: ElevatedButton(onPressed: ()=>Navigator.pop(context), child: const Text('Try Again')),
          );
        }
      );
    }
    setState(() {
      isFetchingData = false;
    });
  }

  onCreateUser(){
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    if(Validation().isEmailValid(email)){
      setState(() {
        isEmailValid = true;
      });
      createUser(firstName, lastName, email);
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(CREATE_USER),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            textFieldCustom(controller: firstNameController, hint: INPUT_FIRST_NAME),
            textFieldCustom(controller: lastNameController, hint: INPUT_LAST_NAME),
            textFieldCustom(controller: emailController, hint: INPUT_EMAIL, isDataValid: isEmailValid),
            ElevatedButton(onPressed: isFetchingData?null : onCreateUser, child: isFetchingData ? const CircularProgressIndicator() : const Text(CREATE_USER))
          ],
        ),
      ),
    );
  }
}