
import 'dart:io';

import 'package:social_media/models/user.dart';
import 'package:social_media/services/api_service.dart';

const createUserPath = 'user/create';

class UserService extends ApiService{
  Future<User> createUser(String firstName, String lastName, String email)async{
    var params = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email
    };
    try{
      final response = await postRequest(createUserPath, params);
      if(response.statusCode==HttpStatus.ok){
        return User.fromMap(response.data);
      } else {
        throw response.data['data'];
      }
    } catch(e){
      throw Exception(e);
    }
  }
}