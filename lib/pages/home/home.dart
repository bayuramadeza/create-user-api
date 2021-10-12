import 'package:flutter/material.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/services/post_service.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;
  late String id;
  int page = 0;
  List<Post>? posts;

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  getPost()async{
    try{
      final result = await PostService().getPost(page.toString());
      setState(() {
        posts = result.data;
      });
    } catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timeline"),
        actions: [
          GestureDetector(
            onTap: ()async{
              final result = await Navigator.pushNamed(context, '/createPost');
              if(result!=null){
                if(result==true){
                  setState(() {
                    posts = null;
                  });
                  getPost();
                }
              }
            },
            child: const Center(child: Text("Create Post")),
          ),
          
        ],
      ),
      body: posts==null? const Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: posts!.length,
        itemBuilder: (BuildContext context, int index) {
          final post = posts![index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey)
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                post.image!=null?const SizedBox() : FadeInImage(placeholder: const NetworkImage('https://c.tenor.com/I6kN-6X7nhAAAAAj/loading-buffering.gif'), image: NetworkImage(post.image!)),
                Row(
                  children: [
                    Icon(Icons.favorite),
                    Text(post.likes.toString()),
                    SizedBox(width: 12),
                    Icon(Icons.comment),
                    SizedBox(width: 12),
                    Icon(Icons.share),
                  ],
                ),
                Text(post.text),
                const SizedBox(height: 8),
                SizedBox(
                  height: 24,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: post.tags!.length,
                    itemBuilder: (BuildContext context, int indexTag) {
                      return Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey
                          ),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(post.tags![indexTag], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}