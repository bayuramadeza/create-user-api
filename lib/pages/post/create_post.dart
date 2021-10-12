import 'package:flutter/material.dart';
import 'package:social_media/services/post_service.dart';
import 'package:social_media/utils/constanta.dart';
import 'package:social_media/utils/preferences_config.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({ Key? key }) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String userId = PreferencesConfig.getString(USER_ID_KEY);
  final postController = TextEditingController();

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
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

  createPost(String post)async{
    try{
      await PostService().createPost(userId, post);
      showDialog(context: context, builder: (_){
        return AlertDialog(
          title: const Text("Your post has been submitted"),
          content: ElevatedButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context, true);
           }, child: const Text('Okay')),
        );
      });
    } catch(e){
      debugPrint(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Column(
        children: [
          textFieldCustom(controller: postController, hint: 'Tell me something'),
          const SizedBox(height: 32),
          ElevatedButton(onPressed: ()=> createPost(postController.text), child: const Text("Submit"))
        ],
      )
    );
  }
}