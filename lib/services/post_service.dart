
import 'dart:io';

import 'package:social_media/models/post.dart';

import 'api_service.dart';

const createPostPath = 'post/create';
const getPostPath = 'post/';

class PostService extends ApiService{
  Future<Post> createPost(String owner, String post)async{
    var params = {
      "owner": owner,
      "text": post,
    };
    try{
      final response = await postRequest(createPostPath, params);
      if(response.statusCode==HttpStatus.ok){
        return Post.fromJson(response.data);
      } else {
        throw response.data['data'];
      }
    } catch(e){
      throw Exception(e);
    }
  }

  Future<PostResponse> getPost(String page, {String limit = '10'})async{
    var params = {
      'page' : page, //1
      'limit': limit //default = 10
    };
    try{
      final response = await getRequest(getPostPath, params);
      if(response.statusCode==HttpStatus.ok){
        return PostResponse.fromJson(response.data);
      } else {
        throw response.data['data']??'Error Occured';
      }
    } catch(e){
      throw Exception(e);
    }
  }
}